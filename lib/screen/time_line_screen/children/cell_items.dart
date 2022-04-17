import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/time_line_details/time_line_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';
import 'package:intl/intl.dart';
import 'border_item.dart';

class CellItems extends StatefulWidget {
  const CellItems({
    Key? key,
    required this.index,
    required this.postAccount,
    required this.post,
  }) : super(key: key);

  final int index;
  final Account postAccount;
  final Post post;

  @override
  _CellItemsState createState() => _CellItemsState();
}

class _CellItemsState extends State<CellItems> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimeLineDetailScreen(
              post: widget.post,
              postAccount: widget.postAccount,
              index: widget.index,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: widget.index == 0
              ? BorderItem.borderFirst()
              : BorderItem.borderOther(),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.w, top: 15.w, bottom: 15.w, right: 10.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.w,
                          backgroundImage:
                              NetworkImage(widget.postAccount.image),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          widget.postAccount.name,
                          style: TextStyle(
                            fontSize: 18.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
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
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.post.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.w,
                      right: 15.w,
                      left: 15.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          widget.post.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.post.comment,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.w,
                        fontWeight: FontWeight.bold,
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
