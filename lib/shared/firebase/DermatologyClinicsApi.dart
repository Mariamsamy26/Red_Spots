import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../model/clinicesModel.dart';

class ClinicesApi {
  Future<List<Clinics>> getClinics(
      double latitude, double longitude) async {
    final url = Uri.parse(
        'https://clinicsapi.runasp.net/Clinics/ClinicsAPI/?lat=$latitude&long=$longitude');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      List<Clinics> clinics = ClinicesModel.fromJson(jsonData).clinics??[];
      return clinics;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
