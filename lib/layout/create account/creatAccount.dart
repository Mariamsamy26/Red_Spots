import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';

import '../../Providers/my_provider.dart';
import '../../shared/components/Custom_ElevatedButton.dart';
import '../../shared/components/custom_textField.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/strings_manager.dart';
import '../Login screen/LoginScreen.dart';
import '../after log in/homeScreenShiled/home_screen.dart';

const List<String> listGender = <String>['Male', 'Female'];
const List<String> listLocation = <String>[
  'Ash Sharqiyah',
  'Aswan',
  'Asyut',
  'Bani Suwayf',
  'Cairo',
  'Port Said',
  'Dumyat ',
  'Gharbiyah',
  'Giza',
  'Ismailiyah',
  'Janub Sina',
  'Kafr ash Shaykh',
  'Matruh',
  'Mit Ghamr',
  'Minufiyah',
  'Minya',
  'Qalyubiyah',
  'Qena',
  'Shamal Sina ',
  'Sohag',
  'Suez',
  'Wadi al Jadid'
];

class CreatAccountScreen extends StatefulWidget {
  static const String rountName = 'Creat Account Screen';

  @override
  State<CreatAccountScreen> createState() => _CreatAccountScreenState();
}

class _CreatAccountScreenState extends State<CreatAccountScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var ageController = TextEditingController();
  var dropdownValueGender;

  var dropdownValueLocation;

  bool isLoding = false;

  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isLoding,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'Create Account',
                  style:
                      TextStyle(fontSize: 30.sp, color: ColorManager.colorWhit),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(45),
                    ScreenUtil().setHeight(100),
                    ScreenUtil().setWidth(30),
                    ScreenUtil().setHeight(25),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '  Sign up',
                          style: TextStyle(
                              fontSize: 32.sp, color: ColorManager.scondeColor),
                        ),
                        SizedBox(height: 10),

                        CustomTextField(
                          keyboardType: TextInputType.name,
                          hintText: 'First Name',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your Name ";
                            }
                            return null;
                          },
                          labelText: StringsManager.FirstN,
                          titleController: fnameController,
                          lengthLimitFormatter:
                              LengthLimitingTextInputFormatter(7),
                          numericFilterFormatter:
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]')),
                        ), //frist_name
                        SizedBox(height: 20.h),

                        CustomTextField(
                          keyboardType: TextInputType.name,
                          hintText: 'Last Name',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your Name ";
                            }
                            return null;
                          },
                          labelText: StringsManager.LastN,
                          titleController: lnameController,
                          lengthLimitFormatter:
                              LengthLimitingTextInputFormatter(7),
                          numericFilterFormatter:
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z]')),
                        ), //last_name
                        SizedBox(height: 20.h),

                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Example@gmail.com',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your E-email ";
                            }
                            return null;
                          },
                          labelText: StringsManager.EmailAddress,
                          titleController: emailController,
                          lengthLimitFormatter:
                              LengthLimitingTextInputFormatter(60),
                          numericFilterFormatter:
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\w+@._%+-]')),
                        ), //Email
                        SizedBox(height: 20.h),

                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hintText: '*******',
                          validator: (text) {
                            if (text?.isEmpty ?? false) {
                              return "Please Enter Your Passowerd ";
                            }
                            return null;
                          },
                          labelText: StringsManager.passwordHint,
                          titleController: passwordController,
                          lengthLimitFormatter: LengthLimitingTextInputFormatter(60),
                            numericFilterFormatter: FilteringTextInputFormatter.allow(
                                RegExp(r'[\w+@._%+-]')),
                        ), //password
                        SizedBox(height: 20.h),

                        CustomTextField(
                          titleController: ageController,
                          hintText: 'Age',
                          labelText: 'Age',
                          keyboardType: TextInputType.number,
                          lengthLimitFormatter: LengthLimitingTextInputFormatter(3),
                          numericFilterFormatter: FilteringTextInputFormatter.allow(
                              RegExp(r'^(?:[1-9]|[1-9][0-9]|[1-9][0-9][0-9]|120)$')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your age";
                            }
                            //build > flutter > build apk
                            final int? age = int.tryParse(value);
                            if (age == null || age < 5 || age >= 120) {
                              return "Age must be between 5 and 120";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20.h),

                        DropdownMenu<String>(
                          menuHeight: 200.h,
                          width: 290.w,
                          hintText: 'Select Gender',
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValueGender = value!;
                            });
                          },
                          dropdownMenuEntries: listGender
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ), //Gender
                        SizedBox(height: 20.h),

                        DropdownMenu<String>(
                          menuHeight: 200.h,
                          width: 290.w,
                          hintText: 'Select location',
                          onSelected: (String? value) {
                            setState(() {
                              dropdownValueLocation = value!;
                            });
                          },
                          dropdownMenuEntries: listLocation
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ), //location
                        SizedBox(
                          height: 10.h,
                        ),

                        CustomElevatedButton(
                          text: 'Creat Account',
                          OnPressed: () {
                            isLoding = true;
                            setState(() {});
                            if (formKey.currentState!.validate()) {
                              firebaseFunctions.CreatUser(
                                  fnameController.text,
                                  lnameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  int.parse(ageController.text),
                                  dropdownValueGender,
                                  dropdownValueLocation,
                                      () {
                                pro.initUser();
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Home_Screen.rountName, (route) => false);
                                isLoding = false;
                                setState(() {});
                              },
                                      (errormassage) {
                                showSnackBar(context, errormassage);
                                isLoding = false;
                                setState(() {});
                              });
                            }
                            isLoding = false;
                          },
                        ), //Sign in

                        SizedBox(height: 30.h),
                        InkWell(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()));
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account ',
                                style: TextStyle(fontSize: 18.spMin),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'login',
                                      style: TextStyle(
                                        fontSize: 18.spMax,
                                        decoration: TextDecoration.underline,
                                      )),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String massage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }
}
