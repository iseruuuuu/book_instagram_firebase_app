import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/screen/my_page_screen/my_root_screen/my_page_root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'children/check_email_button_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckEmailScreen extends StatefulWidget {
  final String email;
  final String pass;
  final UserCredential result;

  const CheckEmailScreen({
    Key? key,
    required this.email,
    required this.pass,
    required this.result,
  }) : super(key: key);

  @override
  _CheckEmailScreenState createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'メールアドレスから認証を行ってください',
              style: TextStyle(
                fontSize: 17.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            CheckEmailButtonItem(
              onTap: () async {
                var result = await Authentication.emailSignIn(
                  email: widget.email,
                  pass: widget.pass,
                );
                if (result is UserCredential) {
                  if (result.user!.emailVerified == true) {
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    await UserFireStore.getUser(result.user!.uid);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyPageRootScreen(),
                      ),
                    );
                  } else {
                    openDialog();
                  }
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
          title: const Text("認証エラー"),
          content: const Text(
            "認証が確認できませんでした。\n"
            "メールボックスを確認してみてください",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
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
