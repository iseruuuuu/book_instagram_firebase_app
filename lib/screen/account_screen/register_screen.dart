import 'dart:io';
import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/utils/funciton_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'check_email_screen.dart';
import 'children/text_field_item.dart';
import 'package:dotted_border/dotted_border.dart';

import 'children/user_id_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIDController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  File? image;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        title: const Text(
          '新規登録',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30.w,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              (image == null)
                  //TODO ダイアログで、画像を選択するか写真を選択するかのダイアログを出す
                  //TODO  画像が全てアップロードできるかを確認する
                  ? GestureDetector(
                      onTap: () async {
                        var result = await FunctionUtils.getImageFromGallery();
                        if (result != null) {
                          setState(() {
                            image = File(result.path);
                          });
                        }
                      },
                      child: DottedBorder(
                        child: SizedBox(
                          width: 100.w,
                          height: 100.w,
                        ),
                      ),
                    )
                  //TODO ダイアログで、画像を選択するか写真を選択するかのダイアログを出す
                  : GestureDetector(
                      onTap: () async {
                        var result = await FunctionUtils.getImageFromGallery();
                        if (result != null) {
                          setState(() {
                            image = File(result.path);
                          });
                        }
                      },
                      child: DottedBorder(
                        child: SizedBox(
                          width: 100.w,
                          height: 100.w,
                          child: Image.file(image!),
                        ),
                      ),
                    ),
              TextFieldItem(
                controller: nameController,
                hintText: 'ユーザー名',
                maxLength: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '@',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.w,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UserIdTextFieldItem(
                    controller: userIDController,
                    hintText: 'ユーザーID',
                    maxLength: 15,
                  ),
                ],
              ),
              TextFieldItem(
                controller: emailController,
                hintText: 'メールアドレス',
                maxLength: 40,
              ),
              TextFieldItem(
                controller: passController,
                hintText: 'パスワード',
                maxLength: 15,
              ),
              SizedBox(height: 15.w),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 50.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.lightBlueAccent,
                  ),
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passController.text.isNotEmpty &&
                        nameController.text.isNotEmpty &&
                        userIDController.text.isNotEmpty) {
                      var result = await Authentication.signUp(
                          email: emailController.text,
                          pass: passController.text);
                      imagePath = await FunctionUtils.uploadImage(
                        PostFireStore.posts.doc().id,
                        image!,
                      );
                      if (result is UserCredential) {
                        Account newAccount = Account(
                          id: result.user!.uid,
                          name: nameController.text,
                          userId: userIDController.text,
                          image: imagePath!,
                        );
                        var _result = await UserFireStore.setUser(newAccount);
                        if (_result == true) {
                          result.user!.sendEmailVerification();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckEmailScreen(
                                email: emailController.text,
                                pass: passController.text,
                                result: result,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    '登録',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.w,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
