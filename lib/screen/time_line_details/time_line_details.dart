import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TimeLineDetailScreen extends StatefulWidget {
  const TimeLineDetailScreen({
    Key? key,
    required this.index,
    required this.postAccount,
    required this.post,
  }) : super(key: key);

  final int index;
  final Account postAccount;
  final Post post;

  @override
  _TimeLineDetailScreenState createState() => _TimeLineDetailScreenState();
}

class _TimeLineDetailScreenState extends State<TimeLineDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.yellow,
        backgroundColor: Colors.white,
        leading: IconButton(
          iconSize: 30.w,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30.w,
            onPressed: openDeleteDialog,
            icon: const Icon(Icons.delete),
            color: Colors.black,
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: Image.network(
                            widget.post.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.star_border),
                            color: Colors.black,
                            iconSize: 40.w,
                            onPressed: () {},
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.messenger_outline),
                          //   color: Colors.black,
                          //   iconSize: 35.w,
                          //   onPressed: () {},
                          // ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            color: Colors.black,
                            iconSize: 35.w,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 30.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.post.title,
                            style: TextStyle(
                              fontSize: 25.w,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy/MM/dd').format(
                              widget.post.createTime!.toDate(),
                            ),
                            style: TextStyle(
                              fontSize: 15.w,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0.w),
                        child: Center(child: Text(widget.post.comment)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openDeleteDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("投稿を削除"),
          content: const Text("本当にこの投稿を削除してもよろしいですか？"),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                PostFireStore.deletePost(
                  widget.post,
                  widget.postAccount,
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
