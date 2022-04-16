import 'package:book_instagram_for_firebase/screen/post_screen/post_screen.dart';
import 'package:book_instagram_for_firebase/screen/time_line_screen/time_line_image_screen.dart';
import 'package:book_instagram_for_firebase/screen/time_line_screen/time_line_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeLineRootScreen extends StatefulWidget {
  const TimeLineRootScreen({Key? key}) : super(key: key);

  @override
  _TimeLineRootScreenState createState() => _TimeLineRootScreenState();
}

class _TimeLineRootScreenState extends State<TimeLineRootScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    const Tab(text: '投稿'),
    const Tab(text: '画像'),
  ];

  List<Widget> pageList = [
    const TimeLineScreen(),
    const TimeLineImageScreen(),
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
          backgroundColor: CupertinoColors.secondarySystemBackground,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
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
      floatingActionButton: SizedBox(
        height: 80.w,
        width: 80.w,
        child: FittedBox(
          //TODO 追加ボタンのデザインを考え直す
          child: FloatingActionButton(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 5,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostScreen(),
                ),
              );
            },
            child: Icon(
              Icons.add_box_outlined,
              size: 40.w,
            ),
          ),
        ),
      ),
    );
  }
}
