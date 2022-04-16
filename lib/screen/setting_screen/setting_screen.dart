import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/edit_screen.dart';
import 'package:book_instagram_for_firebase/screen/account_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InAppReview inAppReview = InAppReview.instance;
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('設定'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('アカウント編集'),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditScreen()),
                  );
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.local_police),
                title: const Text('ライセンス'),
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LicensePage()),
                  );
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.mail),
                title: const Text('お問い合わせ'),
                onPressed: (context) async {
                  const url =
                      'https://docs.google.com/forms/d/e/1FAIpQLScvyVmwmzc_acPaCKaM0EER7iNP7zxL0YJsGqV7saEqdT8M1g/viewform?usp=sf_link';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    openDialog(
                      context: context,
                      title: 'URLエラー',
                      content: 'URLが開けませんでした。\n'
                          'もう一度押してみるか、\n'
                          '一度アプリを再起動してみてください。',
                    );
                  }
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.star),
                title: const Text('レビューする'),
                onPressed: (context) async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  } else {
                    openDialog(
                      context: context,
                      title: 'レビューができませんでした。',
                      content: 'レビューができませんでした。\n'
                          'お手数ですが、もう一度お試しください',
                    );
                  }
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('ログアウト'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('ログアウト'),
                onPressed: (context) {
                  logOutDialog(
                    context: context,
                    title: 'ログアウト確認',
                    content: 'ログアウトしてもよろしいですか？\n'
                        '再度ログインすることで利用することができます',
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('アカウント削除'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: const Text('アカウント削除'),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  void openDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
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

  void logOutDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "キャンセル",
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
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
                }),
          ],
        );
      },
    );
  }
}
