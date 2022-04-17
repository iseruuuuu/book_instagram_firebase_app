import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/my_page_screen/children/my_cell_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'children/no_list_item.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
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
                          return SmartRefresher(
                            enablePullUp: true,
                            enablePullDown: true,
                            header: const WaterDropHeader(),
                            controller: refreshController,
                            onLoading: _onLoading,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                Post post = snapshot.data![index];
                                return MyCellItems(
                                  index: index,
                                  postAccount: myAccount,
                                  post: post,
                                  isMyAccount: true,
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
          ),
        ],
      ),
    );
  }
}
