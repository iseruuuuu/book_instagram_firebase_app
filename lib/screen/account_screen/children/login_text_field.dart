import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextFieldItem extends StatelessWidget {
  const LoginTextFieldItem({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: SizedBox(
        width: 300.w,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          style: TextStyle(
            fontSize: 20.w,
          ),
          autocorrect: false,
          decoration: InputDecoration(hintText: hintText),
        ),
      ),
    );
  }
}
