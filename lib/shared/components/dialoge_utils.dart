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
}