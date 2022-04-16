import 'package:book_instagram_for_firebase/screen/account_screen/edit_screen.dart';
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
                title: const Text('アカウント'),
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
                  } else if (await canLaunch(url)) {
                    // 最初のURLが開けなかった場合かつセカンドURLが有って開けた場合
                    await launch(url);
                  } else {
                    // 任意のエラー処理
                  }
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.star),
                title: const Text('レビューする'),
                onPressed: (context) async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
