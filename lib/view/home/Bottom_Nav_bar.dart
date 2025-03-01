
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:r_creative/contants/color.dart';
import 'package:r_creative/view/More/More.dart';
import 'package:r_creative/view/News/News.dart';
import 'package:r_creative/view/Profile/Profile.dart';
import 'package:r_creative/view/home/Home_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
       Home(),
  News(),
      ProfileScreen(),
      MoreScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
           activeColorPrimary: MyColors.mycolor3,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper),
        title: "News",
               activeColorPrimary: MyColors.mycolor3,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_4_sharp),
        title: "Profile",
              activeColorPrimary: MyColors.mycolor3,
        inactiveColorPrimary: Colors.grey,
      ),
       PersistentBottomNavBarItem(
        icon: const Icon(Icons.more),
        title: "More",
        activeColorPrimary: MyColors.mycolor3,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      navBarStyle: NavBarStyle.style3, // Customize style
    );
  }
}

class ScreenWidget extends StatelessWidget {
  final String title;
  final Color color;

  ScreenWidget({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: color),
      body: Center(
        child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}