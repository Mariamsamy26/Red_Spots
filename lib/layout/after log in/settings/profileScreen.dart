import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Providers/img_Providers.dart';
import '../../../Providers/my_provider.dart';
import '../../../shared/components/Custom_ElevatedAccountFill.dart';
import '../../../shared/style/color_manager.dart';
import '../../Login screen/LoginScreen.dart';
import '../add tab/DermatologyClinicMapScreen.dart';
import 'About.dart';
import 'EditProfile.dart';

class ProfileScreen extends StatefulWidget {
  static const String rountName ='profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _profileScreeenState();

}

class _profileScreeenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var pro =Provider.of<MyProvider>(context);
    var prov = Provider.of<ImgProvider>(context);
    return Stack(
      children: [
        Image.asset("assets/images/ProfilePG.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 80, 10, 10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 50, // Image radius
                                  backgroundImage: (prov.imagePathProfile != null)
                                      ? FileImage(File(prov.imagePathProfile!.path))as ImageProvider<Object>
                                      : AssetImage('assets/images/Profilephoto.png'),
                                ),
                              ]),

                          SizedBox(width:8),

                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height:10),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    '${pro.accountData?.fNAME} ${pro.accountData?.lNAME}',
                                    style: TextStyle(
                                      color: ColorManager.colorGrayBlue,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Text('${pro.accountData?.age} years',
                                  style: TextStyle(
                                    color: ColorManager.colorGrayBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),
                              ]),
                        ]
                    ),

                    Column(
                      children: [
                        SizedBox(height: 30),
                        CustomElevatedAccountFill(
                          icon: Icons.edit_outlined,
                          text: 'Edit profile',
                          onPressed: () async {
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                            setState(() {
                              var currentPhoto = 'assets/images/profile_english.png'; // Update photo
                              var currentName = '${pro.accountData?.fNAME} ${pro.accountData?.lNAME}'; // Update name
                              var currentAge = '${pro.accountData?.age} '; // Update age
                            });
                          },
                        ),
                        CustomElevatedAccountFill(
                          icon: Icons.medical_services_outlined,
                          text: 'Clinices',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DermatologyClinicMapScreen()));
                          },),

                        CustomElevatedAccountFill(
                          icon: Icons.language,
                          text: 'Language',
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                        CustomElevatedAccountFill(
                          icon: Icons.login,
                          text: 'log out',
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(context, LogInScreen.rountName, (route) => false);
                          },
                        ),
                        CustomElevatedAccountFill(
                          icon: Icons.info_outline,
                          text: 'About',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => aboutScreeen()));
                          },),
                      ],
                    ),
                  ],),
              ),
            )
        ),
      ],
    );
  }
}