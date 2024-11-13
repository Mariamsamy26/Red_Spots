import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/my_provider.dart';
import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/firebase/firebase_function.dart';
import '../../../shared/style/color_manager.dart';
import '../homeScreenShiled/history_screen.dart';
import 'DermatologyClinicMapScreen.dart';

class reportScreen extends StatefulWidget {
  @override
  _reportScreenState createState() => _reportScreenState();
}

class _reportScreenState extends State<reportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    final userId = pro.accountData?.id;
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/Doctor.png'),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: ColorManager.colorWhit,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(height: 70, width: 40),
                              Text(
                                'Report',
                                style: TextStyle(
                                  color: ColorManager.colorParper,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: Column(
                              children: [
                                for (var i = 0; i < report.length; ++i)
                                  ListTile(
                                    title: Text(report[i]["type"],
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    subtitle: Text(
                                      "sore:${report[i]["level"]}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black38),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomElevatedButton(
                                    colorButton: ColorManager.colorWhit,
                                    colorText: ColorManager.primaryColor,
                                    colorBorder: ColorManager.primaryColor,
                                    text: 'home',
                                    OnPressed: () {
                                      firebaseFunctions.insertReport(
                                          report, userId!);
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    },
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  flex: 2,
                                  child: CustomElevatedButton(
                                    colorButton: ColorManager.primaryColor,
                                    colorBorder: ColorManager.primaryColor,
                                    text: 'Dermatology Clinic',
                                    OnPressed: () {
                                      firebaseFunctions.insertReport(
                                          report, userId!);
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DermatologyClinicMapScreen()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List report = [
    // {"type": "normal", "level": "0.755"},
    // {"type": "Not Define", "level": "0.234"},
    // {"type": "UPNormal", "level": "0.354"},
    // {"type": "psoriatic Nail", "level": "0.022"},
    // {"type": "psoriatic Arthritis", "level": "0.110"},

    {"type": "psoriatic Nail", "level": "0.687"},
    {"type": "psoriatic Arthritis", "level": "0.210"},
    {"type": "Not Define", "level": "0.134"},
    {"type": "UPNormal", "level": "0.897"},
    {"type": "normal", "level": "0.109"},
  ];
}
