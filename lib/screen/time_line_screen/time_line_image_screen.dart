import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'children/image_cell_item.dart';

class TimeLineImageScreen extends StatefulWidget {
  const TimeLineImageScreen({Key? key}) : super(key: key);

  @override
  _TimeLineImageScreenState createState() => _TimeLineImageScreenState();
}

class _TimeLineImageScreenState extends State<TimeLineImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: PostFireStore.posts
            .orderBy('created_time', descending: true)
            .snapshots(),
        builder: (context, postSnapshot) {
          if (postSnapshot.hasData) {
            List<String> postAccountIds = [];
            for (var doc in postSnapshot.data!.docs) {
              Map<String, dynamic> data = doc.data();
              if (!postAccountIds.contains(data['post_account_id'])) {
                postAccountIds.add(data['post_account_id']);
              }
            }
            return FutureBuilder<Map<String, Account>?>(
              future: UserFireStore.getPostUserMap(postAccountIds),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: postSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = postSnapshot.data!.docs[index].data();
                      Post post = Post(
                        id: postSnapshot.data!.docs[index].id,
                        postAccountId: data['post_account_id'],
                        createTime: data['created_time'],
                        image: data['image'],
                        title: data['title'],
                      );
                      Account postAccount =
                          userSnapshot.data![post.postAccountId]!;
                      return ImageCellItem(
                        index: index,
                        postAccount: postAccount,
                        post: post,
                        isMyAccount: false,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
