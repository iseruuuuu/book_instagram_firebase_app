import 'package:book_instagram_for_firebase/firebase/authentication.dart';
import 'package:book_instagram_for_firebase/model/account.dart';
import 'package:book_instagram_for_firebase/screen/setting_screen/setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my_page_image_screen.dart';
import 'my_page_screen.dart';

class MyPageRootScreen extends StatefulWidget {
  const MyPageRootScreen({Key? key}) : super(key: key);

  @override
  _MyPageRootScreenState createState() => _MyPageRootScreenState();
}

class _MyPageRootScreenState extends State<MyPageRootScreen>
    with SingleTickerProviderStateMixin {
  Account myAccount = Authentication.myAccount!;

  final List<Tab> tabs = <Tab>[
    const Tab(text: '投稿'),
    const Tab(text: '画像'),
  ];

  List<Widget> pageList = [
    const MyPageScreen(),
    const MyPageImageScreen(),
  ];
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.secondarySystemBackground,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.w,
                  backgroundImage: NetworkImage(myAccount.image),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myAccount.name,
                      style: TextStyle(
                        fontSize: 15.w,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@' + myAccount.userId,
                      style: TextStyle(
                        fontSize: 13.w,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            iconSize: 30.w,
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ],
        centerTitle: false,
        bottom: TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          controller: controller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: pageList,
      ),
    );
  }
}
