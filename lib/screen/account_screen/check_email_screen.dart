import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/screen/root_screen/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(
                '認証のメールを送信しました',
                style: TextStyle(
                  fontSize: 25.w,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/check_email.png',
                width: 130.w,
                height: 130.w,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '⚠︎メールが届かない場合は、迷惑メールを確認するか、メールアドレスの入力を間違えているか確認する必要があります。',
                  style: TextStyle(
                    fontSize: 17.w,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              CheckEmailButtonItem(
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
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
                          builder: (context) => const RootScreen(),
                        ),
                      );
                    } else {
                      openDialog();
                    }
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              const Spacer(),
            ],
          ),
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
