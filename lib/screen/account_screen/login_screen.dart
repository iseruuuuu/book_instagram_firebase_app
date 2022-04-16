import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/register_screen.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/reset_email_screen.dart';
import 'package:book_instagram_for_firebase/screen/root_screen/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    if (currentUser.emailVerified) {
      await UserFireStore.getUser(currentUser.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        title: const Text(
          'Book Instant Telegram',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(),
              LoginTextFieldItem(
                controller: emailController,
                hintText: 'メールアドレス',
              ),
              const Spacer(),
              LoginTextFieldItem(
                controller: passController,
                hintText: 'パスワード',
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'パスワードを忘れた方は',
                      style: TextStyle(
                        fontSize: 20.w,
                      ),
                    ),
                    TextSpan(
                      text: 'こちら',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.w,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetEmailScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.w),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'アカウントの作成は',
                      style: TextStyle(
                        fontSize: 20.w,
                      ),
                    ),
                    TextSpan(
                      text: 'こちら',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.w,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.lightBlueAccent,
                  ),
                  onPressed: () async {
                    var result = await Authentication.emailSignIn(
                        email: emailController.text, pass: passController.text);
                    if (result is UserCredential) {
                      if (result.user!.emailVerified == true) {
                        await UserFireStore.getUser(result.user!.uid);
                        if (result = true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RootScreen(),
                            ),
                          );
                        }
                      } else {
                        //TODO ダイアログを作成する
                        print('メールの認証ができていません');
                      }
                    } else {
                      openDialog();
                    }
                  },
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.w,
                    ),
                  ),
                ),
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
          title: const Text("ログイン失敗"),
          content: Text(
            "\n"
            "メールアドレスまたはパスワードが\n"
            "正しくありません。"
            "\n",
            style: TextStyle(
              fontSize: 14.w,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
