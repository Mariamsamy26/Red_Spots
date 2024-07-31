import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/clinicesModel.dart';
import '../shared/components/Custom_LocationDermatologyClinic.dart';
import '../shared/style/color_manager.dart';

class MapProvider extends ChangeNotifier {
  Location location = Location();
  PermissionStatus status = PermissionStatus.denied;
  LocationData? locationData;
  StreamSubscription<LocationData>? subscription;
  bool isServiceEnabled = false;
  List<Marker> markers = [];
  Set<Marker> markersClinics = {};
  CameraPosition? myLocation;
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  Completer<GoogleMapController> controllerCompleter = Completer();
  int index = 0;
  ClinicesModel? clinicsData;

  //List<Clinics>? clinics;

  backCarrant() {
    markers.clear();
    if (locationData != null) {
      markers.add(Marker(
        markerId: MarkerId("MyLocation"),
        position: LatLng(locationData!.latitude!, locationData!.longitude!),
      ));

      CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!),
        zoom: 17,
      );
      controller.future.then((controller) {
        controller
            .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
      });
    }
  }

  Future<void> initializeMap() async {
    await getUserLocation();
  }

  Future<bool> checkPermission() async {
    status = await location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await location.requestPermission();
    }
    return (status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited);
  }

  Future<bool> checkService() async {
    isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }
    return isServiceEnabled;
  }

  Future<void> getUserLocation() async {
    bool permission = await checkPermission();
    if (!permission) return;
    bool service = await checkService();
    if (!service) return;

    locationData = await location.getLocation();
    location.changeSettings(
      interval: 30000,
      distanceFilter: 2,
      accuracy: LocationAccuracy.high,
    );
    subscription = location.onLocationChanged.listen((event) {
      locationData = event;
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("MyLocation"),
        position: LatLng(event.latitude!, event.longitude!),
        // updateUserLocationByTap(),
      ));
      myLocation = CameraPosition(
        target: LatLng(event.latitude!, event.longitude!),
        zoom: 17,
      );
      notifyListeners();
      print("lat: ${locationData?.latitude}, Long: ${locationData?.longitude}");
    });
  }

  void updateUserLocationByTap(LatLng position) {
    myLocation = CameraPosition(
      target: position,
      zoom: 17,
    );
    notifyListeners();
  }

  double getMarkerHue(Color color) {
    final hsvColor = HSVColor.fromColor(color);
    return hsvColor.hue;
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }
}
