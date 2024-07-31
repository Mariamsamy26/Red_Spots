class ClinicesModel {
  String? code;
  String? message;
  List<Clinics>? clinics;
  bool isNotEmpty = true;

  ClinicesModel({
    this.clinics,
    this.code,
    this.message,
  });

  ClinicesModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    if (json['clinics'] != null) {
      clinics = [];
      json['clinics'].forEach((v) {
        clinics?.add(Clinics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.clinics != null) {
      data['clinics'] = this.clinics?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinics {
  String? name;
  double? longitude;
  double? latitude;
  String? phone;
  double? rate;
  String? addressClinic;
  double? distance;

  Clinics({
    this.name,
    this.longitude,
    this.latitude,
    this.phone,
    this.rate,
    this.addressClinic,
    this.distance,
  });

  Clinics.fromJson(dynamic json) {
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone = json['phone'];
    rate = json['rate']?.toDouble();
    addressClinic = json['addressClinic'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;

    return data;
  }
}
