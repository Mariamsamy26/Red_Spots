import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';

import '../../Providers/my_provider.dart';
import '../../shared/components/Custom_ElevatedButton.dart';
import '../../shared/components/custom_textField.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/strings_manager.dart';
import '../after log in/homeScreenShiled/home_screen.dart';
import '../create account/creatAccount.dart';

class LogInScreen extends StatefulWidget {
  static const String rountName = 'logIn';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoding = false;
  bool read = false;

  @override
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
            fit: BoxFit.fitWidth,
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  'Welcome Back',
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '  Log in',
                          style: TextStyle(
                              fontSize: 32.sp, color: ColorManager.scondeColor),
                        ),
                        SizedBox(height: 30.h),

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
                          onChanged: (data) {},
                          titleController: emailController,
                        ), //Email
                        SizedBox(height: 20.h),

                        Text("password"),
                        TextFormField(
                          validator: (text) {
                            if (text?.isEmpty ?? true) {
                              return "Please enter your password";
                            }
                            return null;
                          },
                          obscureText: read ? false : true,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "*********" ,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  read = !read;
                                });
                              },
                              icon: Icon(
                                read ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 12), // Adjust height here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(239, 239, 239, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        CustomElevatedButton(
                          text: 'log in',
                          OnPressed: () {
                            isLoding = true;
                            setState(() {});
                            if (formKey.currentState!.validate()) {
                              firebaseFunctions.loginUser(
                                  emailController.text, passwordController.text,
                                  () {
                                pro.initUser();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Home_Screen.rountName,
                                  (route) => false,
                                );
                                isLoding = false;
                                setState(() {});
                              }, (errormassage) {
                                showSnackBar(context, errormassage);
                                isLoding = false;
                                setState(() {});
                              });
                            }
                          },
                        ), //login

                        SizedBox(height: 230.h),

                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreatAccountScreen()));
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'Don`t have an account?',
                                style: TextStyle(fontSize: 18.sp.spMin),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'sign up',
                                      style: TextStyle(
                                          fontSize: 18.sp.spMax,
                                          decoration:
                                              TextDecoration.underline)),
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
