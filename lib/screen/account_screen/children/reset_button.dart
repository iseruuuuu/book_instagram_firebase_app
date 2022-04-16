import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
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
          primary: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        onPressed: onTap,
        child: Text(
          'メール送信',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.w,
          ),
        ),
      ),
    );
  }
}
