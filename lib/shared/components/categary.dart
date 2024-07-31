import 'package:flutter/material.dart';

import '../style/color_manager.dart';

class CustomIconBottom extends StatelessWidget {
  String iconPath;
  String text;
  double radius;
  double width;
  double height;
  double heightIcon;
  double widthIcon;
  void Function()? OnPressed;

  CustomIconBottom({
    required this.text,
    required this.OnPressed,
    required this.radius,
    required this.width,
    required this.heightIcon,
    required this.widthIcon,
    required this.height,
    this.iconPath = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          onPressed: OnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(237, 215, 241, 1.0),
            elevation: 0.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                ),
                child: Image.asset(iconPath, width: widthIcon, height: heightIcon),
              ),
              Text(text,
                  style: TextStyle(
                    color: ColorManager.scondeColor,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
    );
  }
}
