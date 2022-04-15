import 'package:book_instagram_for_firebase/screen/account_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //複数解像度対応
    return ScreenUtilInit(
      //ターゲットデバイスの設定
      designSize: const Size(375, 812),
      //幅と高さの最小値に応じてテキストサイズを可変させるか
      minTextAdapt: true,
      //split screenに対応するかどうか？
      splitScreenMode: true,
      builder: (BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
