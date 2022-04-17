import 'package:book_instagram_for_firebase/screen/post_screen/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonItems extends StatelessWidget {
  const FloatingActionButtonItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.width / 5,
      child: FloatingActionButton(
        elevation: 20,
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: MediaQuery.of(context).size.width / 9,
          color: Colors.black,
        ),
      ),
    );
  }
}
