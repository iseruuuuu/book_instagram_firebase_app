import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/firebase/user_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../account_screen/children/text_field_item.dart';
import '../../account_screen/children/update_button.dart';

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
      backgroundColor: CupertinoColors.secondarySystemBackground,
      appBar: AppBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 310.w,
              child: Text(
                'ユーザー名',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            TextFieldItem(
              controller: nameController,
              hintText: '',
              maxLength: 15,
            ),
            const Spacer(),
            SizedBox(
              width: 310.w,
              child: Text(
                'ユーザーID',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.w,
                  color: Colors.grey,
                ),
              ),
            ),
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
                  hintText: '',
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
                    image: myAccount.image,
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
          ],
        ),
      ),
    );
  }
}
