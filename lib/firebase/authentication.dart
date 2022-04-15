import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp({required String email, required String pass}) async {
    try {
      UserCredential newAccount = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print('auth登録完了');
      return newAccount;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      return false;
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String pass}) async {
    try {
      final UserCredential result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = result.user;
      print('authサインイン完了');
      return result;
    } on FirebaseAuthException catch (e) {
      print('authサインエラー');
      return false;
    }
  }

  static sendPasswordResetEmail({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (error) {
      print(error.code);
      return error.code;
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  static Future<void> deleteAuth() async {
    await currentFirebaseUser!.delete();
  }
}
