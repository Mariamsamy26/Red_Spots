import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/layout/after%20log%20in/photoNavigator.dart';

import '../../../Providers/img_Providers.dart';
import '../../../shared/components/Custom_ElevatedAccountFill.dart';
import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/components/question_item.dart';
import '../../../shared/style/color_manager.dart';
import 'chickPhotoScreen.dart';
import 'DermatologyClinicMapScreen.dart';

class QuestionScreen extends StatefulWidget {
  static const String RountName = 'Add Photo Screen';

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    implements PhotoNavigator {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ImgProvider>(context);
    pro.navigator = this;
    return Stack(
      children: [
        Image.asset(
          "assets/images/ProfilePG.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Questions',
              style: TextStyle(fontSize: 23, color: ColorManager.colorGrayBlue),
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
                    QuestionsItem(
                      AnswerText1: 'white to pink',
                      AnswerText2: 'brown',
                      AnswerText3: 'black',
                      QuestionText: 'color of your skin',
                    ),
                    QuestionsItem(
                        QuestionText: 'color of spot',
                        AnswerText1: 'brown',
                        AnswerText2: 'red',
                        AnswerText3: 'black'),
                    QuestionsItem(
                        QuestionText: 'Did the spot Appearance After Infiction',
                        AnswerText1: ' Yes ',
                        AnswerText2: 'No'),
                    QuestionsItem(
                        QuestionText: 'The Spot Accomained by severe itching',
                        AnswerText1: 'Yes',
                        AnswerText2: 'No '),
                    QuestionsItem(
                        QuestionText: 'There pain in the Spot',
                        AnswerText1: 'Yes ',
                        AnswerText2: 'No'),
                    QuestionsItem(
                        QuestionText: 'There a bump in the spot',
                        AnswerText1: 'Yes ',
                        AnswerText2: 'No'),
                    QuestionsItem(
                        QuestionText: 'There a spot get bigger quickly',
                        AnswerText1: 'Yes ',
                        AnswerText2: 'No'),

                    CustomElevatedButton(
                      width: 250,
                      colorBorder: ColorManager.primaryColor,
                      colorButton: ColorManager.primaryColor,
                      colorText: ColorManager.colorWhit,
                      text: 'Take photo',
                      OnPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Choose best way . . . ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  CustomElevatedAccountFill(
                                    icon: Icons.camera_alt_outlined,
                                    text: 'Camera',
                                    onPressed: () { 
                                      pro.pickImageCamera();
                                    },
                                    dividerColor: Colors.transparent,
                                  ), //Camera
                                  SizedBox(
                                    height: 5,
                                  ),
                                  CustomElevatedAccountFill(
                                    icon:
                                    Icons.photo_library_outlined,
                                    text: 'Gallery',
                                    onPressed: () {
                                      pro.pickImageGallery(context);
                                    },
                                    dividerColor: Colors.transparent,
                                  ), //Gallery
                                  Row(
                                    children: [
                                      SizedBox(width: 200),
                                      InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 14),
                                          )) //
                                    ],
                                  ) //Cancel
                                ],
                              ),
                            ));
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void NavigateToPhoto() {
    Navigator.pushNamed(context, chickPhotoScreen.rountName);
  }
}
