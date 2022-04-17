import 'dart:io';
import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/utils/funciton_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../account_screen/children/update_button.dart';

class EditIconScreen extends StatefulWidget {
  const EditIconScreen({Key? key}) : super(key: key);

  @override
  _EditIconScreenState createState() => _EditIconScreenState();
}

class _EditIconScreenState extends State<EditIconScreen> {
  Account myAccount = Authentication.myAccount!;
  File? image;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        title: const Text(
          'アイコン変更',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          iconSize: 30.w,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            (image == null)
                ? GestureDetector(
                    onTap: openPictureDialog,
                    child: DottedBorder(
                      child: SizedBox(
                        width: 200.w,
                        height: 200.w,
                        child: Image.network(myAccount.image),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: openPictureDialog,
                    child: DottedBorder(
                      child: SizedBox(
                        width: 200.w,
                        height: 200.w,
                        child: Image.file(image!),
                      ),
                    ),
                  ),
            const Spacer(),
            UpdateButton(onPressed: () async {
              var setImage = '';
              if (image == null) {
                Navigator.pop(context, true);
              } else {
                imagePath = await FunctionUtils.uploadImage(
                  PostFireStore.posts.doc().id,
                  image!,
                );
                setImage = imagePath!;
                Account updateAccount = Account(
                  id: myAccount.id,
                  name: myAccount.name,
                  userId: myAccount.userId,
                  image: setImage,
                );
                Authentication.myAccount = updateAccount;
                var result = await UserFireStore.updateUser(updateAccount);
                if (result == true) {
                  //TODO 戻った時に状態変化をさせてあげたい→Loading画面で反映させた方がいいかも？？
                  //TODO 更新の処理がうまくいってない
                  Navigator.pop(context, true);
                }
              }
            }),
            const Spacer(),
          ],
        ),
      ),
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
