import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:book_instagram_for_firebase/screen/time_line_details/time_line_details.dart';
import 'package:flutter/material.dart';

class ImageCellItem extends StatelessWidget {
  const ImageCellItem({
    Key? key,
    required this.index,
    required this.postAccount,
    required this.post,
    required this.isMyAccount,
  }) : super(key: key);

  final int index;
  final Account postAccount;
  final Post post;
  final bool isMyAccount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TimeLineDetailScreen(
              post: post,
              postAccount: postAccount,
              index: index,
            ),
          ),
        );
      },
      child: Image.network(
          post.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
