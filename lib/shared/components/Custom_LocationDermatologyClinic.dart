import 'package:flutter/cupertino.dart';

class DermatologyClinic {
  final String name;
  final String phone ;
  final double rate ;
  final double latitude;
  final double longitude;

  DermatologyClinic( {
    required this.phone,
    required this.name,
    required this.rate,
    required this.latitude,
    required this.longitude,
  });

  //@override Widget build(BuildContext context) { }
}