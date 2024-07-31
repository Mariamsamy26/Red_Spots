import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_spotss/model/AccountData.dart';
import 'package:red_spotss/shared/firebase/firebase_function.dart';

class MyProvider extends ChangeNotifier {
  AccountData? accountData;
  User? firebaseUser;

  MyProvider() {
    print("Provider init-----");
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    accountData =
        await firebaseFunctions.readUserFromFirebase(firebaseUser!.uid);
    notifyListeners();
  }
}
