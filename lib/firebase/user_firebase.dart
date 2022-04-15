import 'package:book_instagram_for_firebase/firebase/post_firebase.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authentication.dart';

class UserFireStore {
  static final fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      fireStoreInstance.collection('users');

  static Future<dynamic> setUser(Account account) async {
    try {
      await users.doc(account.id).set({
        'name': account.name,
        'user_id': account.userId,
        'created_time': Timestamp.now(),
        'image': account.image,
      });
      print('新規ユーザー作成完了');
      return true;
    } on FirebaseException catch (e) {
      print('新規ユーザー作成エラー' '$e');
      return false;
    }
  }

  static Future<dynamic> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        id: uid,
        name: data['name'],
        userId: data['user_id'],
        createdTime: data['created_time'],
        image: data['image'],
      );
      Authentication.myAccount = myAccount;
      return true;
    } on FirebaseException catch (e) {
      print('ユーザー取得エラー:$e');
      return false;
    }
  }

  static Future<dynamic> updateUser(Account updateAccount) async {
    try {
      await users.doc(updateAccount.id).update({
        'name': updateAccount.name,
        'user_id': updateAccount.userId,
        'created_time': Timestamp.now(),
        'image': updateAccount.image,
      });
      print('ユーザー情報の更新完了');
      return true;
    } on FirebaseException catch (e) {
      print('ユーザー情報の更新失敗 $e');
      return false;
    }
  }

  static Future<Map<String, Account>?> getPostUserMap(
      List<String> accountIds) async {
    Map<String, Account> map = {};
    try {
      await Future.forEach(accountIds, (String accountIds) async {
        var doc = await users.doc(accountIds).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Account postAccount = Account(
          id: accountIds,
          name: data['name'],
          userId: data['user_id'],
          createdTime: data['created_time'],
          image: data['image'],
        );
        map[accountIds] = postAccount;
        print('投稿ユーザーの情報を習得完了');
      });
      return map;
    } on FirebaseException catch (e) {
      print('ユーザーの情報取得失敗 $e');
      return null;
    }
  }

  static Future<dynamic> deleteUser(String accountId) async {
    await users.doc(accountId).delete();
    PostFireStore.deleteAllPosts(accountId);
  }
}
