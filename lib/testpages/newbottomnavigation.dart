import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/healthcare/healthcare.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/pages/notification/notification.dart';
import 'package:newhealthapp/pages/profile/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class NewBottomNavigationBar extends StatefulWidget {
  // late final int? tabIndex;
  GlobalKey? form = GlobalKey();

  @override
  _NewBottomNavigationBarState createState() => _NewBottomNavigationBarState();

  NewBottomNavigationBar([this.form]);
}

class _NewBottomNavigationBarState extends State<NewBottomNavigationBar> {
  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    HealthCare(),
    Notifications(),
    Profile()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home,
            size: 30,
            color: Colors.teal,
          ),
          title: 'Home',
          activeColorPrimary: Colors.teal.shade100,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          activeColorSecondary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.teal,
          ),
          title: 'Healthcare',
          activeColorPrimary: Colors.teal.shade100,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: Colors.black),
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.notifications,
            color: Colors.teal,
            size: 20,
          ),
          title: 'Notifications',
          activeColorPrimary: Colors.teal.shade100,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: Colors.black),
      PersistentBottomNavBarItem(
          textStyle: const TextStyle(color: Colors.black),
          icon: const Icon(
            Icons.person,
            color: Colors.teal,
          ),
          title: 'Account',
          activeColorPrimary: Colors.teal.shade100,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: Colors.black),
    ];
  }

  int cons = 0;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex:0);

  late final int selectedIndex;
  late final ValueChanged<int> onItemSelected;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey ,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _widgetOptions,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.black,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 100),
        ),
        navBarStyle: NavBarStyle.style7,
      ),
    );
  }
}
