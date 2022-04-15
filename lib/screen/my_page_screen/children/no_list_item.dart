import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoListItem extends StatelessWidget {
  const NoListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(
            '投稿がありません',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27.w,
            ),
          ),
          Text(
            '右下の「＋」ボタンで投稿することができます。',
            style: TextStyle(
              fontSize: 14.w,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 40.w),
          // Image.asset(
          //   'assets/images/ramen_icon.png',
          //   width: 150.w,
          //   height: 150.w,
          // ),
          const Spacer(),
        ],
      ),
    );
  }
}
