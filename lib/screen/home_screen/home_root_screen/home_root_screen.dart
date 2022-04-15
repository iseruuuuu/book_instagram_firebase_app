import 'package:book_instagram_for_firebase/screen/home_screen/home_screen/home_image_screen.dart';
import 'package:book_instagram_for_firebase/screen/home_screen/home_screen/home_screen.dart';
import 'package:book_instagram_for_firebase/screen/post_screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeRootScreen extends StatefulWidget {
  const HomeRootScreen({Key? key}) : super(key: key);

  @override
  _HomeRootScreenState createState() => _HomeRootScreenState();
}

class _HomeRootScreenState extends State<HomeRootScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Home'),
    const Tab(text: 'Image'),
  ];

  List<Widget> pageList = [
    const HomeScreen(),
    const HomeImageScreen(),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.w),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.grey,
            unselectedLabelColor: Colors.grey,
            controller: controller,
            tabs: tabs,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: pageList,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
