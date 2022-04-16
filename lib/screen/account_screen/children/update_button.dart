import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      height: 60.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          elevation: 10,
        ),
        onPressed: onPressed,
        child: Text(
          '更新',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
