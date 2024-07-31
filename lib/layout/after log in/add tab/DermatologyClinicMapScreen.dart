import 'dart:async';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:red_spotss/shared/style/color_manager.dart';

import '../../../Providers/maps_Provider.dart';
import '../../../model/clinicesModel.dart';
import '../../../shared/firebase/DermatologyClinicsApi.dart';

class DermatologyClinicMapScreen extends StatefulWidget {
  static const String RountName = 'Dermatology Clinic Map Screen';
  late final List<Clinics> Clinices;
  ClinicesModel? clinicsData;

  @override
  State<DermatologyClinicMapScreen> createState() =>
      _DermatologyClinicMapScreenState();
}

class _DermatologyClinicMapScreenState
    extends State<DermatologyClinicMapScreen> {
  late MapProvider mapProv;
  late int index;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Completer<GoogleMapController> controller =
        Completer<GoogleMapController>();
    mapProv = Provider.of<MapProvider>(context);
    mapProv.initializeMap();
    index = mapProv.index;
  }

  @override
  void dispose() {
    mapProv.dispose();
    super.dispose();
  }

  @override
  //AIzaSyDpER28SEqR5_CLW56Jvj2WyvWweOUQdz4 mapKey
  Widget build(BuildContext context) {
    mapProv.getUserLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dermatology Clinics Map'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              mapProv.backCarrant();
              setState(() {});
            },
            icon: const Icon(
              Icons.my_location_sharp,
              color: ColorManager.colorGrayBlue,
            ),
          ),
        ],
        backgroundColor: ColorManager.scondeColor,
      ),
      body: mapProv.myLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.satellite,
              markers: Set<Marker>.of(
                  [...mapProv.markers, ...mapProv.markersClinics]).toSet(),
              onTap: (argument) {
                setState(() {
                  mapProv.markers.clear();
                  index++;
                  mapProv.markers.add(Marker(
                      markerId: MarkerId("marker$index"), position: argument));
                  setState(() {});
                });
              },
              initialCameraPosition: mapProv.myLocation!,
              onMapCreated: (GoogleMapController controller) {
                mapProv.controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.primaryColor,
        onPressed: () {
          getNearbyDermatologyClinicsApi(mapProv.locationData!.longitude!,
              mapProv.locationData!.latitude!);
        },
        label: const Text(
          'Dermatology Clinics',
          style: TextStyle(fontSize: 20, color: ColorManager.colorWhit),
        ),
        icon: const Icon(
          Icons.medical_services,
          color: ColorManager.colorWhit,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> getNearbyDermatologyClinicsApi(
      double? longitude, double? latitude) async {
    var clinicsApi = ClinicesApi();
    var clinics = await clinicsApi.getClinics(longitude!, latitude!);
    if (clinics.isNotEmpty) {
      print(
          "locationData ${mapProv.locationData!.longitude!} ${mapProv.locationData!.latitude}");
      for (var clinic in clinics) {
        var clinicLatLng = LatLng(clinic.latitude ?? 0, clinic.longitude ?? 0);
        print("distanceIs ${clinic.name} ${clinic.distance}");
        mapProv.markersClinics.add(
          Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
                mapProv.getMarkerHue(ColorManager.primaryColor)),
            markerId: MarkerId(clinic.name ?? "clinic"),
            position: clinicLatLng,
            infoWindow: InfoWindow(
              title: clinic.name!,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.black12, width: 3),
                  ),
                  builder: (BuildContext context) {
                    return FractionallySizedBox(
                      heightFactor: 0.6.h,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.person_rounded,
                                    size: 35,
                                    color: ColorManager.primaryColor,
                                  ),
                                  Flexible(
                                    child: Text(
                                      clinic.name ?? "clinic",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: ColorManager.colorGrayBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ), // Name
                              SizedBox(height: 15.h),

                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating:
                                        (clinic.rate ?? 4.5).toDouble(),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: ColorManager.primaryColor,
                                    ),
                                    ignoreGestures: true,
                                    // Disable user input
                                    onRatingUpdate: (double value) {},
                                  ),
                                  Text(
                                    clinic.rate.toString(),
                                  )
                                ],
                              ), // Rate
                              SizedBox(height: 10.h),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 25,
                                    color: ColorManager.primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      mapProv.makePhoneCall(
                                          clinic.phone ?? "01210060085");
                                    },
                                    child: Text(
                                      clinic.phone ?? "01210060085",
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            ColorManager.colorGrayBlue,
                                        //color: ColorManager.primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ), // Phone
                              SizedBox(height: 10.h),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_searching_sharp,
                                    size: 30,
                                    color: ColorManager.primaryColor,
                                  ),
                                  Flexible(
                                    child: Text(
                                      clinic.addressClinic ?? "Cairo ",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: ColorManager.colorGrayBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ), //add
                              SizedBox(height: 10.h),
/*
                              Row(
                                children: [
                                  const Icon(
                                    Icons.social_distance_sharp,
                                    size: 25,
                                    color: ColorManager.primaryColor,
                                  ),
                                  Flexible(
                                    child: Text(
                                      ' ${(clinic.distance ?? 5) } km',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: ColorManager.colorGrayBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ), //distance
 */
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      }
      setState(() {
        mapProv.markersClinics = Set<Marker>.from(mapProv.markersClinics);
        //markersClinicsprint(mapProv.markersClinics.length);
        //print("clinics lesgth ${clinics.distance}");
      });
    } else {
      // Handle empty clinic list
    }
  }
}
