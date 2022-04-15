import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/reset_button.dart';
import 'children/text_field_item.dart';

class ResetEmailScreen extends StatefulWidget {
  const ResetEmailScreen({Key? key}) : super(key: key);

  @override
  _ResetEmailScreenState createState() => _ResetEmailScreenState();
}

class _ResetEmailScreenState extends State<ResetEmailScreen> {
  TextEditingController emailController = TextEditingController();
  String email = '';
  final String address = '@rissho-univ.jp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 30.w,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'パスワード再設定メールの送信',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                ),
              ),
              TextFieldItem(
                  controller: emailController,
                  hintText: 'メールアドレス',
                  maxLength: 100),
              SizedBox(height: 10.w),
              ResetButton(
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    var result = await Authentication.sendPasswordResetEmail(
                      email: emailController.text,
                    );
                    if (result == true) {
                      openDialog(
                        text: 'パスワード再設定のメールを送信しました\n'
                            'メールを確認してみてください。',
                        title: '送信成功',
                      );
                    } else if (result == 'invalid-email') {
                      openDialog(
                        text: '無効なメールアドレスです\n'
                            'もう一度お試しください',
                        title: '無効なメールアドレス',
                      );
                    } else if (result == 'user-not-found') {
                      openDialog(
                        text: 'メールアドレスが登録されていません\n'
                            'もう一度お試しください',
                        title: 'エラー',
                      );
                    } else {
                      openDialog(
                        text: 'メール送信に失敗しました。\n'
                            'もう一度お試しください',
                        title: 'エラー',
                      );
                    }
                  } else {
                    openDialog(
                      text: 'テキストフィールドにメールアドレスを入力してください',
                      title: 'テキストフィールドが空です',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog({required String text, required String title}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(
            text,
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
}
