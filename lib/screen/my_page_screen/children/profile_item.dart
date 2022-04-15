import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.myAccount,
  }) : super(key: key);

  final Account myAccount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              myAccount.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 25.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              myAccount.userId,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
      ],
    );
  }
}
