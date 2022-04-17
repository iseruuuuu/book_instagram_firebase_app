import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';
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
  bool isMyAccount = false;

  @override
  void initState() {
    super.initState();
    if (widget.post.postAccountId == Authentication.myAccount!.id) {
      isMyAccount = true;
    } else {
      isMyAccount = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        leading: IconButton(
          iconSize: 30.w,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          isMyAccount
              ? IconButton(
                  onPressed: openDeleteDialog,
                  icon: HeroIcon(
                    HeroIcons.dotsHorizontal,
                    color: Colors.black,
                    size: 30.w,
                  ),
                )
              : Container(),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  SizedBox(height: 30.w),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: Text(
                      widget.post.title,
                      style: TextStyle(
                        fontSize: 25.w,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Text(
                      DateFormat('yyyy/MM/dd').format(
                        widget.post.createTime!.toDate(),
                      ),
                      style: TextStyle(
                        fontSize: 15.w,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                    child: Center(
                      child: Text(
                        widget.post.comment,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
          title: const Text("投稿の削除の確認"),
          content: Text(
            "\nこの投稿を削除します。\n"
            "よろしいですか？\n",
            style: TextStyle(
              fontSize: 17.w,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "キャンセル",
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
                "OK",
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
