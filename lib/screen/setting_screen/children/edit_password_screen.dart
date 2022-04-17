import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/children/reset_button.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../account_screen/children/text_field_item.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
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
            children: [
              const Spacer(),
              Text(
                'パスワード再設定メールの送信',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23.w,
                ),
              ),
              const Spacer(),
              TextFieldItem(
                controller: emailController,
                hintText: 'メールアドレス',
                maxLength: 100,
              ),
              const Spacer(),
              SizedBox(height: 15.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '①登録済みのメールアドレス宛に、パスワード再設定用のURLが記載されてたメールが送信されます。',
                  style: TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '⚠︎URLの有効期限は１時間です。　　　　　　　　　　　　　　　',
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '②メールに記載されたURLから新しいパスワードを設定してください。',
                  style: TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '⚠︎メールが届かない場合は、迷惑メールを確認するか、メールアドレスの入力を間違えているか確認する必要があります。',
                  style: TextStyle(
                    fontSize: 16.w,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              ResetButton(
                onTap: () async {
                  if (emailController.text.isNotEmpty) {
                    var result = await Authentication.sendPasswordResetEmail(
                      email: emailController.text,
                    );
                    if (result == true) {
                      openDialog(
                        text: '\n'
                            'パスワード再設定メールを送信しました\n'
                            '\n'
                            'メールをご確認してみてください。'
                            '\n',
                        title: '再設定メール送信成功',
                        isLogout: true,
                      );
                    } else if (result == 'invalid-email') {
                      openDialog(
                        text: '\n'
                            '無効なメールアドレスです\n'
                            'もう一度お試しください'
                            '\n',
                        title: '無効なメールアドレス',
                        isLogout: false,
                      );
                    } else if (result == 'user-not-found') {
                      openDialog(
                        text: '\n'
                            'メールアドレスが登録されていません\n'
                            'もう一度お試しするか\n'
                            '登録画面から登録をお願いします'
                            '\n',
                        title: '登録されていないアドレス',
                        isLogout: false,
                      );
                    } else {
                      openDialog(
                        text: '\n'
                            'メール送信に失敗しました。\n'
                            'もう一度お試しください'
                            '\n',
                        title: 'エラー',
                        isLogout: false,
                      );
                    }
                  } else {
                    openDialog(
                      text: '\n'
                          'メールアドレスを入力してください'
                          '\n',
                      title: '入力エラー',
                      isLogout: false,
                    );
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog({
    required String text,
    required String title,
    required bool isLogout,
  }) {
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
              child: Text(
                isLogout ? 'ログアウト' : 'OK',
              ),
              onPressed: () {
                if (isLogout) {
                  Authentication.signOut();
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
