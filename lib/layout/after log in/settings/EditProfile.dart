import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';
import '../../../Providers/img_Providers.dart';
import '../../../Providers/my_provider.dart';
import '../../../shared/components/CustomTextFieldEdit.dart';
import '../../../shared/components/Custom_ElevatedAccountFill.dart';
import '../../../shared/components/Custom_ElevatedButton.dart';
import '../../../shared/style/color_manager.dart';
import '../../../shared/style/strings_manager.dart';

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

class EditProfileScreen extends StatefulWidget {
  static const String routeName = 'EditProfileScreen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String fnameData;
  late String lnameData;
  late String emailData;
  late String ageData;
  late String dropdownValueGender;
  late String dropdownValueLocation;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    var pro = Provider.of<MyProvider>(context, listen: false);
    setState(() {
      fnameData = pro.accountData?.fNAME ?? '';
      lnameData = pro.accountData?.lNAME ?? '';
      emailData = pro.accountData?.email ?? '';
      ageData = pro.accountData?.age?.toString() ?? '';
      dropdownValueGender = pro.accountData?.gender ?? listGender[0];
      dropdownValueLocation = pro.accountData?.location ?? listLocation[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    var prov = Provider.of<ImgProvider>(context);

    return Stack(
      children: [
        Image.asset(
          "assets/images/ProfilePG.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 30, color: ColorManager.colorWhit),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  buildProfileImage(prov),
                  const SizedBox(height: 20),

                  CustomTextFieldEdit(
                    keyboardType: TextInputType.name,
                    labelText: StringsManager.FirstN,
                    initialValue: fnameData,
                    onPressed: (newData) => fnameData = newData,
                    lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
                    numericFilterFormatter:
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    validator: (text) {
                      if (text?.isEmpty ?? false) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                  ), //FirstN
                  const SizedBox(height: 20),

                  CustomTextFieldEdit(
                    keyboardType: TextInputType.name,
                    labelText: StringsManager.LastN,
                    initialValue: lnameData,
                    onPressed: (newData) => lnameData = newData,
                    lengthLimitFormatter: LengthLimitingTextInputFormatter(10),
                    numericFilterFormatter:
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                    validator: (newData) {
                      if (newData?.isEmpty ?? false) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                  ), //lastN
                  const SizedBox(height: 20),

                  CustomTextFieldEdit(
                    keyboardType: TextInputType.number,
                    labelText: StringsManager.Age,
                    initialValue: '${pro.accountData?.age}',
                    onPressed: (newData) {
                      ageData = newData;
                    },
                    lengthLimitFormatter: LengthLimitingTextInputFormatter(3),
                    numericFilterFormatter: FilteringTextInputFormatter.allow(
                        RegExp(r'^(?:[1-9]|[1-9][0-9]|[1-9][0-9][0-9]|120)$')),
                    validator: (newData) {
                      if (newData == null || newData.isEmpty) {
                        return 'Please enter your age';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(newData)) {
                        return 'Age must be a number';
                      }
                      final int age = int.parse(newData);
                      if (age < 5 || age >= 120) {
                        return 'Age must be between 2 and 120';
                      }
                      return null;
                    },
                  ), //Age
                  const SizedBox(height: 20),

                  CustomTextFieldEdit(
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email Address',
                    initialValue: emailData,
                    onPressed: (newData) => emailData = newData,
                    lengthLimitFormatter: LengthLimitingTextInputFormatter(60),
                    numericFilterFormatter: FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9@.]')),
                    validator: (value) {},
                    enabled: false, // Set to false to make the field read-only and text bold
                  ),//email
                  const SizedBox(height: 20),

                  Container(
                    width: 320.w,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValueGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueGender = newValue!;
                        });
                      },
                      items: listGender
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: 320.w,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValueLocation,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValueLocation = newValue!;
                        });
                      },
                      items: listLocation
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomElevatedButton(
                          colorBorder: ColorManager.primaryColor,
                          colorButton: ColorManager.colorWhit,
                          colorText: ColorManager.primaryColor,
                          text: 'Cancel',
                          OnPressed: () {
                            prov.imagePathProfile = null;
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomElevatedButton(
                          colorBorder: ColorManager.primaryColor,
                          colorButton: ColorManager.primaryColor,
                          colorText: ColorManager.colorWhit,
                          text: 'Save',
                          OnPressed: () {
                            if (formKey.currentState!.validate()) {
                              firebaseFunctions
                                  .updateAccount(
                                      pro.accountData!,
                                      pro.accountData!.fNAME = fnameData,
                                      pro.accountData!.lNAME = lnameData,
                                      pro.accountData!.email = emailData,
                                      pro.accountData!.age = int.parse(ageData),
                                      pro.accountData!.gender =
                                          dropdownValueGender,
                                      pro.accountData!.location =
                                          dropdownValueLocation)
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            }

                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileImage(ImgProvider prov) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: ColorManager.colorWhit),
            borderRadius: BorderRadius.all(Radius.circular(19)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Ink.image(
              fit: BoxFit.fill,
              image: (prov.imagePathProfile != null)
                  ? FileImage(File(prov.imagePathProfile!.path))
                      as ImageProvider<Object>
                  : AssetImage('assets/images/Profilephoto.png'),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Choose best way . . .',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 25),
                      CustomElevatedAccountFill(
                        icon: Icons.camera_alt_outlined,
                        text: 'Camera',
                        onPressed: () {
                          prov.pickImageProfileCamera();
                          Navigator.pop(context); // Close the dialog
                        },
                        dividerColor: Colors.transparent,
                      ),
                      const SizedBox(height: 5),
                      CustomElevatedAccountFill(
                        icon: Icons.photo_library_outlined,
                        text: 'Gallery',
                        onPressed: () {
                          prov.pickImageProfileGallery(context);  // Pass context here
                          Navigator.pop(context); // Close the dialog
                        },
                        dividerColor: Colors.transparent,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child:
                                Text('Cancel', style: TextStyle(fontSize: 14)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 1, color: ColorManager.primaryColor)
                ],
                border: Border.all(width: 3, color: ColorManager.colorWhit),
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
              child: Icon(Icons.edit_outlined, color: ColorManager.colorWhit),
            ),
          ),
        ),
      ],
    );
  }

}
