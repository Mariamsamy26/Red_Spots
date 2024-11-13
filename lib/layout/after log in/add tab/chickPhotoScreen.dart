import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/layout/after%20log%20in/add%20tab/reportScreen.dart';

import '../../../Providers/img_Providers.dart';
import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/style/color_manager.dart';
import 'QuestionScreen.dart';

class chickPhotoScreen extends StatefulWidget {
  static const String rountName = "chickPhotoScreen";

  const chickPhotoScreen({Key? key}) : super(key: key);

  @override
  State<chickPhotoScreen> createState() => _chickPhotoScreenState();
}

bool isCamera = false;

class _chickPhotoScreenState extends State<chickPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ImgProvider>(context);
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
                'upload image of your case ',
                style:
                    TextStyle(fontSize: 24, color: ColorManager.colorGrayBlue),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Ink.image(
                      width: double.infinity,
                      height: 500,
                      image: FileImage(File(pro.imagePath!.path)),
                    ), //photo

                    SizedBox(height: 30),

                    //Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                            child: CustomElevatedButton(
                                text: 'Retray',
                                OnPressed: () {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuestionScreen()));
                                },
                             ),
                        ),

                        SizedBox(width: 5),

                        Expanded(
                          flex: 1,
                          child: CustomElevatedButton(
                            text: 'Take Report',
                            OnPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => reportScreen()));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
      ],
    );
  }
}
