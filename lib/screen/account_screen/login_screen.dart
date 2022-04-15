import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/register_screen.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/reset_email_screen.dart';
import 'package:book_instagram_for_firebase/screen/my_page_screen/my_root_screen/my_page_root_screen.dart';
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
          // builder: (context) => const MyPageRootScreen(),
          builder: (context) => const RootScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'ラーメンアルバム',
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'ログイン画面',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              LoginTextFieldItem(
                controller: emailController,
                hintText: 'メールアドレス',
              ),
              LoginTextFieldItem(
                controller: passController,
                hintText: 'パスワード',
              ),

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'パスワードを忘れた方は',
                      style: TextStyle(
                        fontSize: 15.w,
                      ),
                    ),
                    TextSpan(
                      text: 'こちら',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.w,
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

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'アカウントを作成していない方は',
                      style: TextStyle(
                        fontSize: 15.w,
                      ),
                    ),
                    TextSpan(
                      text: 'こちら',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.w,
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    onPrimary: Colors.yellow,
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
                              //builder: (context) => const MyPageRootScreen(),
                            ),
                          );
                        }
                      } else {
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
            "メールアドレスまたはパスワードが\n"
            "正しくありません。",
            style: TextStyle(
              fontSize: 12.5.w,
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
