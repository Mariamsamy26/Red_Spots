import 'package:flutter/material.dart';
import 'Custom_ElevatedAccountFill.dart';

class CustomshowDialog extends StatelessWidget {
  final void Function(void)? cameraFunction;
  final void Function(void)? galleryFunction;
  final Widget child;

  const CustomshowDialog({
    required this.cameraFunction,
    required this.galleryFunction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Choose best way . . . ',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomElevatedAccountFill(
                          icon: Icons.camera_alt_outlined,
                          text: 'Camera',
                          onPressed: () {
                            cameraFunction;
                          },
                          dividerColor: Colors.transparent,
                        ), //Camera
                        SizedBox(
                          height: 5,
                        ),
                        CustomElevatedAccountFill(
                          icon: Icons.photo_library_outlined,
                          text: 'Gallery',
                          onPressed: () {
                            galleryFunction;
                          },
                          dividerColor: Colors.transparent,
                        ), //Gallery
                        Row(
                          children: [
                            SizedBox(width: 200),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 14),
                                )) //
                          ],
                        ) //Cancel
                      ],
                    ),
                  ));
        },
        child: child);
  }
}
