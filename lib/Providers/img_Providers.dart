import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../layout/after log in/photoNavigator.dart';
import '../layout/after log in/add tab/chickPhotoScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

const String apiURL =
    "https://api-infrence.huggiace.co/mdels/ahmedesmail6/Psoriasis-Project-Aug-M2-swinv2-base-patch4-window11-192-2k";

class ImgProvider extends ChangeNotifier {
  XFile? image;
  XFile? imagePath;
  XFile? imagePathProfile ;
  late PhotoNavigator navigator;

  String? _classificationResult;
  File? _image;
  final picker = ImagePicker();

  Future<bool> checkPermissionCamera() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    return status.isGranted || status.isLimited;
  }

  Future<bool> checkPermissionGallery() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      status = await Permission.photos.request();
    }
    return status.isGranted || status.isLimited;
  }

  Future<void> pickImageCamera() async {
    checkPermissionCamera();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      imagePath = imageTemp;
      notifyListeners();
      navigator.NavigateToPhoto();
    } on PlatformException catch (e) {
      return print('Failed to pick image: $e');
    }
  }

  Future<void> pickImageGallery(BuildContext context) async {
    await checkPermissionGallery();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Check file extension to exclude GIFs
      final extension = image.path.split('.').last.toLowerCase();
      if (extension == 'gif') {
        showGifNotAllowedGIF(context);
        return;
      }

      final imageTemp = XFile(image.path);
      imagePath = imageTemp;
      notifyListeners();
      navigator.NavigateToPhoto();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> pickImageProfileCamera() async {
    checkPermissionCamera();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = XFile(image.path);
      imagePathProfile = imageTemp;
      notifyListeners();
      // Perform the task related to the second image here
    } on PlatformException catch (e) {
      return print('Failed to pick image for task 2: $e');
    }
  }

  Future<void> pickImageProfileGallery(BuildContext context) async {
    await checkPermissionGallery();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // Check file extension to exclude GIFs
      final extension = image.path.split('.').last.toLowerCase();
      if (extension == 'gif') {
        showGifNotAllowedGIF(context);
        return;
      }

      final imageTemp = XFile(image.path);
      imagePathProfile = imageTemp;
      notifyListeners();
      // Perform the task related to the second image here
    } on PlatformException catch (e) {
      print('Failed to pick image for task 2: $e');
    }
  }

  Future<void> imgPath() async {
    imagePath = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    print("image path $imagePath");
    notifyListeners();
  }

  Future<void> imgPathProfile() async {
    imagePathProfile = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    print("image path $imgPathProfile");
    notifyListeners();
  }

  void showGifNotAllowedGIF(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'sorry GIF images are not allowed.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> classifyImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final response = await http.post(
        Uri.parse(apiURL),
        headers: {
          //HttpHeaders.authorizationHeader: 'Bearer $apiKey',
          HttpHeaders.contentTypeHeader: 'application/octet-stream',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        {
          _classificationResult = result.toString();
          notifyListeners();
        };
      } else {
        throw Exception('Failed to classify image');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
