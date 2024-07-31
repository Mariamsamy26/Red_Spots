import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/shared/style/my_theme.dart';

import 'Providers/img_Providers.dart';
import 'Providers/maps_Provider.dart';
import 'Providers/my_provider.dart';
import 'firebase_options.dart';
import 'layout/Login screen/LoginScreen.dart';
import 'layout/after log in/add tab/chickPhotoScreen.dart';
import 'layout/after log in/homeScreen.dart';
import 'layout/after log in/settings/EditProfile.dart';
import 'layout/after log in/settings/profileScreen.dart';
import 'layout/create account/creatAccount.dart';
import 'model/clinicesModel.dart';
import 'package:http/http.dart' as http;

FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   importance: Importance.max,
// );

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String? token = await FirebaseMessaging.instance.getToken();
  print("el token $token");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MyProvider()),
      ChangeNotifierProvider(create: (context) => ImgProvider()),
      ChangeNotifierProvider(create: (context) => MapProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //(O)
    // requestNotificationPermission();
    // showRemoteNotification();
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
    // //(B)
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  //
  // requestNotificationPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   print('User granted permission: ${settings.authorizationStatus}');
  // }
  //
  // showRemoteNotification() async {
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification notification = message.notification!;
  //     AndroidNotification? android = message.notification?.android;
  //
  //     // If `onMessage` is triggered with a notification, construct our own
  //     // local notification to show to users using the created channel.
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               icon: android?.smallIcon,
  //               // other properties...
  //             ),
  //           ));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize:  Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        var provider = Provider.of<MyProvider>(context);
        return MaterialApp(
          initialRoute: provider.firebaseUser != null
              ? homeScreen.rountName
              : LogInScreen.rountName,
          routes: {
            LogInScreen.rountName: (c) => LogInScreen(),
            CreatAccountScreen.rountName: (C) => CreatAccountScreen(),
            homeScreen.rountName: (C) => homeScreen(),
            chickPhotoScreen.rountName: (C) => chickPhotoScreen(),
            EditProfileScreen.routeName: (C) => EditProfileScreen(),
            ProfileScreen.rountName: (C) => ProfileScreen(),
          },
          theme: MyThemedata.litetheme,
          darkTheme: MyThemedata.darktheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}