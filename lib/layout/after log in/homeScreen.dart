import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:red_spotss/layout/after%20log%20in/settings/profileScreen.dart';
import '../../shared/style/color_manager.dart';
import 'add tab/QuestionScreen.dart';
import 'homeScreenShiled/home_screen.dart';

class homeScreen extends StatefulWidget {
  static const String rountName ='home';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:tabs[currentIndex] ,

      bottomNavigationBar: BottomAppBar(
        height: 55,
        padding: EdgeInsets.zero,
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: ColorManager.primaryColor,
          elevation: 0.0,
          currentIndex: currentIndex,
          onTap: (index){
            currentIndex=index;
            setState(() {
            });
          },
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home_outlined,size: 21),
                label: "home"),
            BottomNavigationBarItem(icon:Icon(Icons.add_a_photo_outlined,size: 21,) ,
                label: "add"),
            BottomNavigationBarItem(icon:Icon(Icons.settings_outlined,size: 21),
                label: "settings"),
          ],),
      ),
    );
  }
}
List<Widget>tabs=[  Home_Screen(),QuestionScreen(),ProfileScreen()];
