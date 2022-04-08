import 'package:flutter/material.dart';
import 'package:newhealthapp/pages/healthcare/healthcare.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/pages/notification/notification.dart';
import 'package:newhealthapp/pages/profile/profile.dart';

var address = 'Select Address';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int i = 0;
  List<Widget> page = [Home(), HealthCare(), Notifications(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        // iconSize: 25.sp,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: i == 0
                  ? const Icon(Icons.home, size: 30, color: Colors.teal)
                  : const Icon(Icons.home, size: 30, color: Colors.blueGrey),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: i == 1
                ? const Icon(Icons.sentiment_very_satisfied,
                    size: 30, color: Colors.teal)
                : const Icon(Icons.sentiment_very_satisfied,
                    size: 30, color: Colors.blueGrey),
            label: 'Healthcare',
          ),
          BottomNavigationBarItem(
              icon: i == 2
                  ? const Icon(Icons.notifications,
                      size: 30, color: Colors.teal)
                  : const Icon(Icons.notifications,
                      size: 30, color: Colors.blueGrey),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: i == 3
                  ? const Icon(Icons.person, size: 30, color: Colors.teal)
                  : const Icon(Icons.person, size: 30, color: Colors.blueGrey),
              label: 'Account'),
        ],
        onTap: (index) {
          i = index;
          setState(() {});
        },
      ),
      body: page.elementAt(i),
    );
  }
}
