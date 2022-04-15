import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckEmailButtonItem extends StatelessWidget {
  const CheckEmailButtonItem({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        child: Text(
          '認証完了',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
