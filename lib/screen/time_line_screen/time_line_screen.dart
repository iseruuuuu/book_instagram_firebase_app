import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/my_page_screen/children/no_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'children/cell_items.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
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
            if (postAccountIds.isNotEmpty) {
              return FutureBuilder<Map<String, Account>?>(
                future: UserFireStore.getPostUserMap(postAccountIds),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData &&
                      userSnapshot.connectionState == ConnectionState.done) {
                    return SmartRefresher(
                      enablePullUp: true,
                      enablePullDown: true,
                      header: const WaterDropHeader(),
                      controller: refreshController,
                      onLoading: _onLoading,
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: postSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              postSnapshot.data!.docs[index].data();
                          Post post = Post(
                            id: postSnapshot.data!.docs[index].id,
                            postAccountId: data['post_account_id'],
                            createTime: data['created_time'],
                            image: data['image'],
                            title: data['title'],
                            comment: data['comment'],
                          );
                          Account postAccount =
                              userSnapshot.data![post.postAccountId]!;
                          return CellItems(
                            index: index,
                            postAccount: postAccount,
                            post: post,
                            isMyAccount: false,
                          );
                        },
                      ),
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
        },
      ),
    );
  }
}
