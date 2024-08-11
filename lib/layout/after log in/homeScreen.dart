import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_spotss/layout/after%20log%20in/settings/profileScreen.dart';
import '../../shared/style/color_manager.dart';
import 'add tab/QuestionScreen.dart';
import 'homeScreenShiled/home_screen.dart';

class homeScreen extends StatefulWidget {
  static const String rountName = 'home';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: ColorManager.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 21,
                ),
                label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined, size: 21),
                label: "settings"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuestionScreen()));
        },
        child: Icon(
          Icons.add_a_photo_outlined,
          color: ColorManager.colorParper,
        ),
      ),
    );
  }
}

List<Widget> tabs = [
  Home_Screen(key: UniqueKey()),
  ProfileScreen(key: UniqueKey()),
];
