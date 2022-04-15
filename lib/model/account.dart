import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id;
  String name;
  String userId;
  Timestamp? createdTime;
  String image;

  Account({
    this.id = '',
    this.name = '',
    this.userId = '',
    this.createdTime,
    this.image = '',
  });
}
