import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
        ),
        onPressed: onTap,
        child: Text(
          '投稿',
          style: TextStyle(
            fontSize: 20.w,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
