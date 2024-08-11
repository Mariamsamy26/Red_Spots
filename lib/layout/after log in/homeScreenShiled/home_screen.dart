import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/components/categary.dart';
import '../../../shared/style/color_manager.dart';
import '../add tab/DermatologyClinicMapScreen.dart';
import 'history_screen.dart';
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
  DateTime _SelectedDate = DateTime.now();
  final TabController _taskControler = Get.put(TaskController());
  var notifyHelper;

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
          leading: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.nightlight_outlined,
              size: 20,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DermatologyClinicMapScreen()),
                );
              },
              icon: Icon(Icons.location_on_sharp),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              icon: Icon(Icons.notifications_active_outlined),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          backgroundColor: ColorManager.primaryColor,
          elevation: 50,
          title: Text(''),
        ),
        body: Column(
          children: [
            _AddDateBar(),
            SizedBox(height: 18),
            Expanded(
              child: Container(
                color:ColorManager.scondeColor.withOpacity(0.2),
                //child: _showTasks(),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 40, height: 50),
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
                          height: 50,
                          width: 140,
                          radius: 30,
                          heightIcon: 100,
                          widthIcon: 100,
                          iconPath: 'assets/images/pr.png',
                          text: 'Psoriasis',
                          //***page google url**//
                          OnPressed: () {
                            _launchURL("www.psoriasis.com");
                          },
                        ),
                        SizedBox(width: 30, height: 35),
                        CustomIconBottom(
                          height: 50,
                          width: 140,
                          radius: 30,
                          heightIcon: 100,
                          widthIcon: 100,
                          iconPath: 'assets/images/history.png',
                          text: 'History ',
                          OnPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => history_screen()));

                          },
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
            ),
          ],
        ));
  }


  _AddDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorManager.primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black12,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _SelectedDate = date;
          });
        },
      ),
    );
  }

}
