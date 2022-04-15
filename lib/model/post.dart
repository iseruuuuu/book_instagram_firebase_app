import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String postAccountId;
  String image;
  String title;
  Timestamp? createTime;
  String comment;

  Post({
    this.id = '',
    this.postAccountId = '',
    this.image = '',
    this.title = '',
    this.createTime,
    this.comment = '',
  });
}
