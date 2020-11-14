import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:potholeroutes/models/Pothole.dart';
import 'package:potholeroutes/models/ServiceRoute.dart';
import 'package:potholeroutes/services/PersistenceService.dart';

class RestService {
  final String serverUrl = "http://192.168.10.37:8080";

  /* Future<Pothole> fetchPothole() async {
    final response = await http.get("http://20.50.174.60:8080/");
    return Pothole.fromJson(jsonDecode(
        '{"coordinate":{"longitude":100.0,"latitude":72.2},"image":{"url":"/mein/Pfad/zum/bild.png"},"dimensions":{"length":99.2,"width":60.0,"depth":40.0}}'));

    if (response.statusCode == 200) {
      // return Pothole.fromJason(jsonDecode(response.body));

    } else {
      throw Exception("Failed to load album");
    }
  } */

  Future<ServiceRoute> fetchRoute() async {
    try {
      String id = await PersistentService().getContractId();
      final response = await http.get("$serverUrl/route?uuid=$id");
      if (response.statusCode == 200) {
        return ServiceRoute.fromJson(jsonDecode(response.body));
      }
    } on Exception catch (_) {
      return null;
    }
    return null;
  }

  void potholeFixed(String potholeId) {
    try {
      final response = http.delete("$serverUrl/deletePothole/$potholeId");
    } on Exception catch (_) {}
  }
}
