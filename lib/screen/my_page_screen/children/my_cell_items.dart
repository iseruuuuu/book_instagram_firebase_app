import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/time_line_details/time_line_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../home_screen/children/border_item.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MyCellItems extends StatefulWidget {
  const MyCellItems({
    Key? key,
    required this.index,
    required this.postAccount,
    required this.post,
    required this.isMyAccount,
  }) : super(key: key);

  final int index;
  final Account postAccount;
  final Post post;
  final bool isMyAccount;

  @override
  _MyCellItemsState createState() => _MyCellItemsState();
}

class _MyCellItemsState extends State<MyCellItems> {
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
                  SizedBox(
                    height: 10.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 15.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.w,
                          backgroundImage:
                              NetworkImage(widget.postAccount.image),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.postAccount.name,
                          style: TextStyle(
                            fontSize: 20.w,
                            color: Colors.black,
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
                        SizedBox(width: 10.w),
                        (widget.isMyAccount)
                            ? GestureDetector(
                                onTap: openDeleteDialog,
                                // child: Icon(CommunityMaterialIcons.image),
                                child: Text(
                                  '・・・',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.w,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.w),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.post.comment,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
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
              },
            ),
          ],
        );
      },
    );
  }
}
