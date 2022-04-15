import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: SizedBox(
        width: 300.w,
        child: TextField(
          controller: controller,
          style: TextStyle(
            fontSize: 20.w,
            fontWeight: FontWeight.bold,
          ),
          autocorrect: false,
          decoration: InputDecoration(hintText: hintText),
          maxLength: maxLength,
        ),
      ),
    );
  }
}
