import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/home_screen/children/image_cell_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/no_list_item.dart';
import 'children/profile_item.dart';

class MyPageImageScreen extends StatefulWidget {
  const MyPageImageScreen({Key? key}) : super(key: key);

  @override
  _MyPageImageScreenState createState() => _MyPageImageScreenState();
}

class _MyPageImageScreenState extends State<MyPageImageScreen> {
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: UserFireStore.users
                    .doc(myAccount.id)
                    .collection('my_posts')
                    .orderBy('created_time', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<String> myPostIds = List.generate(
                      snapshot.data!.docs.length,
                      (index) {
                        return snapshot.data!.docs[index].id;
                      },
                    );
                    if (myPostIds.isNotEmpty) {
                      return FutureBuilder<List<Post>?>(
                        future: PostFireStore.getPostsFromIds(myPostIds),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Post post = snapshot.data![index];
                                return ImageCellItem(
                                  index: index,
                                  postAccount: myAccount,
                                  post: post,
                                  isMyAccount: true,
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
                        child: NoListItem(),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
