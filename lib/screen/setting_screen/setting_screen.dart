import 'package:book_instagram_for_firebase/screen/account_screen/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('言語'),
                value: const Text('日本語'),
                onPressed: (context) {},
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: const Icon(Icons.format_paint),
                title: const Text('Enable custom theme'),
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.notifications_active),
                title: const Text('お知らせ'),
                onPressed: (context) {},
              ),
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
                onPressed: (context) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.help),
                title: const Text('ヘルプ'),
                onPressed: (context) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.mail),
                title: const Text('お問い合わせ'),
                onPressed: (context) {},
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.star),
                title: const Text('レビューする'),
                onPressed: (context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
