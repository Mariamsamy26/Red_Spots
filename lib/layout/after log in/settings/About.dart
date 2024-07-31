import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/components/Custom_Features.dart';
import '../../../shared/style/color_manager.dart';

class aboutScreeen extends StatefulWidget {
  @override
  State<aboutScreeen> createState() => _aboutScreeenState();
}

class _aboutScreeenState extends State<aboutScreeen> {
  List<String> verses = [];

  //const infoScreeen({Key? key}) : super(key: key);
  void lodeFile() async {
    String contant = await rootBundle.loadString('assets/files/info.txt');
    List<String> lines = contant.split('\n');
    print(lines);
    verses = lines;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (verses.isEmpty) {
      lodeFile();
    }

    return Stack(
      children: [
        Image.asset(
          "assets/images/ProfilePG.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'About',
              style: TextStyle(fontSize: 24, color: ColorManager.colorWhit),
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFeatures(FeaturesTitle: 'Secure Account Creation',
                      DetailsFeatures: 'Patients can create a secure account to store their basic information, eliminating the need for repetitive data entry.',),

                    CustomFeatures(FeaturesTitle: 'Trustworthy Medical Information',
                      DetailsFeatures: 'We provide reliable and vetted information about psoriasis, sparing users the hassle of searching through unknown sources.',),

                    CustomFeatures(FeaturesTitle: 'AI-Powered Diagnosis',
                      DetailsFeatures: 'Users can capture images of their red patches and answer a series of targeted questions. Our artificial intelligence system then provides a diagnosis, determining whether the user is affected by psoriasis or not. In case of diagnosis, it identifies the type of psoriasis and suggests nearby specialized clinics for further consultation.',),

                    CustomFeatures(FeaturesTitle: 'Regular Check-up Reminders:',
                      DetailsFeatures: 'The application sends timely reminders to users for their regular check-ups, ensuring they stay proactive about their health.',),

                    CustomFeatures(FeaturesTitle: 'Data Editing', DetailsFeatures: 'Users have the ability to edit their basic information as needed, providing flexibility and accuracy in their profiles.',),

                    CustomFeatures(FeaturesTitle: 'Multilingual Support',
                      DetailsFeatures: 'The application supports both Arabic and English languages, catering to a diverse user base.',),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
