import 'package:flutter/material.dart';
class DialogeUtils{
 static void showLoadingDialog(BuildContext context,
 {bool isDismissible=true}){
    showDialog(context: context, builder: (buildContext){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12,),
            Text('Loading...'),
          ],
        ),
      );
    },
    barrierDismissible: false,
    );
  }
  static void showMassage(BuildContext context,String massage){
   showDialog(context: context, builder:(buildContext){
     return AlertDialog(content: Text(massage),);
   });
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}