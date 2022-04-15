import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'children/delete_account_button.dart';
import 'children/sign_out_button.dart';
import 'children/text_field_item.dart';
import 'children/update_button.dart';
import 'login_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  Account myAccount = Authentication.myAccount!;
  TextEditingController nameController = TextEditingController();
  TextEditingController useIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    useIdController = TextEditingController(text: myAccount.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          '編集画面',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          iconSize: 30.w,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            TextFieldItem(
              controller: nameController,
              hintText: 'ユーザー名',
              maxLength: 15,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '@',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.w,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18.w),
                  ],
                ),
                TextFieldItem(
                  controller: useIdController,
                  hintText: 'ユーザーID',
                  maxLength: 15,
                ),
              ],
            ),
            const Spacer(),
            UpdateButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    useIdController.text.isNotEmpty) {
                  Account updateAccount = Account(
                    id: myAccount.id,
                    name: nameController.text,
                    userId: useIdController.text,
                  );
                  Authentication.myAccount = updateAccount;
                  var result = await UserFireStore.updateUser(updateAccount);
                  if (result == true) {
                    Navigator.pop(context, true);
                  }
                }
              },
            ),
            const Spacer(),
            SignOutButton(
              onPressed: () async {
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
              },
            ),
            SizedBox(height: 10.w),
            DeleteAccountButton(
              onPressed: () {
                openDialog();
              },
            ),
            const Spacer(),
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
          title: const Text("アカウント削除確認"),
          content: const Text(
            "アカウントを削除しますか？\n"
            "今まで投稿した写真も全て消えてしまいます。",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                UserFireStore.deleteUser(myAccount.id);
                Authentication.deleteAuth();
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
