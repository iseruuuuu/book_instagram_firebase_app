import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterButtonItem extends StatelessWidget {
  const RegisterButtonItem({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        onPressed: onTap,
        child: Text(
          'アカウントを作成',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
