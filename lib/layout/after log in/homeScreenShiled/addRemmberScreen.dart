import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';
import 'package:red_spotss/shared/style/color_manager.dart';
import '../../../model/taskModel.dart';
import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/components/custom_textField.dart';

class AddRemmberScreen extends StatefulWidget {
  static const String rountName = 'add to remmber';

  @override
  State<AddRemmberScreen> createState() => _AddRemmberScreenState();
}

class _AddRemmberScreenState extends State<AddRemmberScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
        "assets/images/ProfilePG.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Add new node"),
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Title node',
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "Please Enter Your E-email ";
                    }
                    return null;
                  },
                  labelText: "Title node ",
                  onChanged: (data) {},
                  titleController: titleController,
                ), //title
                SizedBox(height: 20.h),

                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Description',
                  validator: (text) {
                    if (text?.isEmpty ?? false) {
                      return "Please Enter Your Passowerd ";
                    }
                    return null;
                  },
                  labelText: "Description if node",
                  onChanged: (data) {},
                  titleController: descriptionController,
                ), //Description
                SizedBox(height: 20.h),

                Text(
                  "date is :${selectedDate.toString().substring(0, 10)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                CustomElevatedButton(
                  text: 'select date',
                  OnPressed: () {
                    chooseYourDate();
                  },
                  colorButton: Colors.black12,
                  colorText: ColorManager.scondeColor,
                  width: 150.w,
                  height: 50.h,
                ),

                Spacer(),

                CustomElevatedButton(
                  width: double.infinity,
                  text: 'add',
                  OnPressed: () {
                    print("hereeee ${DateUtils.dateOnly(selectedDate)}");
                    TaskModel model = TaskModel(
                        title: titleController.text,
                        userId: FirebaseAuth.instance.currentUser?.uid ?? "",
                        description: descriptionController.text,
                        date: DateUtils.dateOnly(selectedDate)
                            .millisecondsSinceEpoch);
                    firebaseFunctions.addTask(model).then((value) {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  chooseYourDate() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}
