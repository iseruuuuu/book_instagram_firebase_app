import 'dart:io';
import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/utils/funciton_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/post_button.dart';
import 'children/post_text_field.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool checkLink = false;
  bool checkImage = false;
  File? image;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        title: const Text(
          '新規投稿',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 30.w,
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            (image == null)
                ? GestureDetector(
                    onTap: openPictureDialog,
                    child: DottedBorder(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 200.w,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: openPictureDialog,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 200.w,
                      color: Colors.grey,
                      child: Image.file(image!),
                    ),
                  ),
            PostTextField(
              controller: titleController,
              hintText: '本のタイトル (必須)',
              maxLength: 10,
            ),
            PostTextField(
              controller: commentController,
              hintText: 'コメント',
              maxLength: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    //TODO  画像が全てアップロードできるかを確認する
                    var result = await FunctionUtils.getImageFromGallery();
                    if (result != null) {
                      setState(() {
                        image = File(result.path);
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.w),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.photo_size_select_actual_outlined,
                      size: 30.w,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    //TODO  画像が全てアップロードできるかを確認する
                    var result = await FunctionUtils.getImageFromCamera();
                    if (result != null) {
                      setState(() {
                        image = File(result.path);
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.w),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 30.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.w),
            PostButton(
              onTap: () async {
                if (titleController.text.isNotEmpty) {
                  imagePath = await FunctionUtils.uploadImage(
                    PostFireStore.posts.doc().id,
                    image!,
                  );
                  Post newPost = Post(
                    postAccountId: Authentication.myAccount!.id,
                    title: titleController.text,
                    image: imagePath!,
                    comment: commentController.text,
                  );
                  var result = await PostFireStore.addPost(newPost);
                  if (result == true) {
                    Navigator.pop(context);
                  }
                } else {
                  openDialog();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void openDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            "投稿失敗",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.w,
            ),
          ),
          content: const Text(
            "\n本のタイトルor写真を登録が必要です。\n"
            "もう一度お確かめください。\n",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void openPictureDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('アイコンの登録'),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "写真を撮る",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                var result = await FunctionUtils.getImageFromCamera();
                if (result != null) {
                  setState(() {
                    image = File(result.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                "フォトライブラリ",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                var result = await FunctionUtils.getImageFromGallery();
                if (result != null) {
                  setState(() {
                    image = File(result.path);
                  });
                }
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                "キャンセル",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
