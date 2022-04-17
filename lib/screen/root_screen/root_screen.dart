import 'package:book_instagram_for_firebase/screen/my_page_screen/children/floating_action_button_items.dart';
import 'package:book_instagram_for_firebase/screen/my_page_screen/my_page_root_screen.dart';
import 'package:book_instagram_for_firebase/screen/time_line_screen/time_line_root_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedIndex = 0;
  List<Widget> pageList = [
    const TimeLineRootScreen(),
    const MyPageRootScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingActionButtonItems(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CupertinoColors.secondarySystemBackground,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'タイムライン',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: 'マイページ',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
