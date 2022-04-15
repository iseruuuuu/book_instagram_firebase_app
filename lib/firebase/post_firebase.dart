import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostFireStore {
  static final fireStoreInstance = FirebaseFirestore.instance;
  static final CollectionReference posts =
      fireStoreInstance.collection('posts');

  static Future<dynamic> addPost(Post newPost) async {
    try {
      final CollectionReference userPosts = fireStoreInstance
          .collection('users')
          .doc(newPost.postAccountId)
          .collection('my_posts');

      var result = await posts.add({
        'image': newPost.image,
        'post_account_id': newPost.postAccountId,
        'created_time': Timestamp.now(),
        'title': newPost.title,
        'comment': newPost.comment,
      });
      userPosts.doc(result.id).set({
        'post_id': result.id,
        'created_time': Timestamp.now(),
      });
      print('投稿完了');
      return true;
    } on FirebaseException catch (e) {
      print('投稿失敗 $e');
      return false;
    }
  }

  static Future<List<Post>?> getPostsFromIds(List<String> ids) async {
    List<Post> postList = [];
    try {
      await Future.forEach(ids, (String id) async {
        var doc = await posts.doc(id).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Post post = Post(
          id: doc.id,
          image: data['image'],
          postAccountId: data['post_account_id'],
          createTime: data['created_time'],
          title: data['title'],
          comment: data['comment'],
        );
        postList.add(post);
      });
      print('自分の投稿取得完了');
      return postList;
    } on FirebaseException catch (e) {
      print('自分の投稿取得失敗');
      return null;
    }
  }

  static Future<void> deleteAllPosts(String accountId) async {
    final CollectionReference userPosts = fireStoreInstance
        .collection('users')
        .doc(accountId)
        .collection('my_posts');
    var snapshot = await userPosts.get();
    snapshot.docs.forEach((doc) async {
      //全体に出している投稿内容を削除
      await posts.doc(doc.id).delete();
      //プロフィールにある投稿内容も削除
      userPosts.doc(doc.id).delete();
    });
  }

  static Future<void> deletePosts(String accountId) async {
    final CollectionReference userPosts = fireStoreInstance
        .collection('users')
        .doc(accountId)
        .collection('my_posts');
    var snapshot = await userPosts.get();
    snapshot.docs.forEach((doc) async {
      //全体に出している投稿内容を削除
      await posts.doc(doc.id).delete();
      //プロフィールにある投稿内容も削除
      userPosts.doc(doc.id).delete();
    });
  }

  static Future<void> deletePost(Post post, Account account) async {
    final CollectionReference userPosts = FirebaseFirestore.instance
        .collection('users')
        .doc(account.id)
        .collection('my_posts');
    userPosts.doc(post.id).delete();
    FirebaseFirestore.instance.collection('posts').doc(post.id).delete();
  }
}
