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
              fontSize: 35.w,
            ),
          ),
          Image.asset(
            'assets/images/nolist.png',
            width: 170.w,
            height: 170.w,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
