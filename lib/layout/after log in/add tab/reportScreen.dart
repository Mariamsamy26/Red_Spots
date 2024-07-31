import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/style/color_manager.dart';
import 'DermatologyClinicMapScreen.dart';

class report_Screeen extends StatelessWidget {
  static const String RountName = 'Report Screen';

  const report_Screeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/ProfilePG.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Report',
                style: TextStyle(fontSize: 30, color: ColorManager.colorWhit),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(text: 'MAPS',
                        OnPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DermatologyClinicMapScreen()));
                        },
                        width: 170,height: 50),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
