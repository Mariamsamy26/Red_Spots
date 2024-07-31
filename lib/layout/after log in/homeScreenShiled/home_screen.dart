import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/components/categary.dart';
import '../../../shared/style/color_manager.dart';
import 'helpScreen.dart';
import 'notification.dart';

class Home_Screen extends StatefulWidget {
  static const String rountName = 'home';
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "http", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "can not lunch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    void _onDaySelected(DateTime day, DateTime focusedDay) {
      setState(() {
        today = day;
      });
    }


    return Scaffold(
        backgroundColor: ColorManager.colorWhit,
        appBar: AppBar(
          //title: Text('welcome back' ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => helpScreen(
                              videoUrl: '',
                            )),
                  );

                   */
                },
                icon: Icon(Icons.help_outline)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()),
                  );
                },
                icon: Icon(Icons.notifications_active_outlined))
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          backgroundColor: ColorManager.primaryColor,
          elevation: 50,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.all(1),
                color: ColorManager.primaryColor,
                child: TableCalendar(
                    locale: 'en_Us',
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    focusedDay: today,
                    onDaySelected: _onDaySelected,
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    firstDay: DateTime.utc(2000, 01, 01),
                    lastDay: DateTime.utc(2040, 01, 01)),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 40, height: 20),
                          Text('Category',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconBottom(
                            height: 70,
                            width: 160,
                            radius: 10,
                            heightIcon: 120,
                            widthIcon: 150,
                            iconPath: 'assets/images/pr.png',
                            text: 'Psoriasis',
                            //***page google url**//
                            OnPressed: () {
                              _launchURL("www.mayoclinic.org");
                            },
                          ),
                          SizedBox(width: 30, height: 35),
                          CustomIconBottom(
                            height: 70,
                            width: 160,
                            radius: 10,
                            heightIcon: 120,
                            widthIcon: 150,
                            iconPath: 'assets/images/history.png',
                            text: 'History ',
                            OnPressed: () {},
                          ),
                        ],
                      ),

                      //   SizedBox(width: 30, height: 35),
                      // Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //   CustomIconBottom(
                      //   height: 40,
                      // width: 130,
                      //iconPath: 'assets/images/eczema.png',
                      //text: 'Eczema',
                      //OnPressed: () {
                      //_launchURL("url");
                      //},
                      //),
                      //SizedBox(width: 30, height: 60),
                      //       CustomIconBottom(
                      //       height: 40,
                      //     width: 130,
                      //   iconPath: 'assets/images/history.png',
                      // text: 'History',
                      //OnPressed: () {},
                      //       ),
                      //   ],
                      //        ),
                      SizedBox(width: 30, height: 60),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
