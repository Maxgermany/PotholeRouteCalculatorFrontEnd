import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:potholeroutes/models/Pothole.dart';
import 'package:potholeroutes/models/ServiceRoute.dart';

class RestService {
  Future<Pothole> fetchPothole() async {
    final response = await http.get("http://20.50.174.60:8080/");
    return Pothole.fromJson(jsonDecode(
        '{"coordinate":{"longitude":100.0,"latitude":72.2},"image":{"url":"/mein/Pfad/zum/bild.png"},"dimensions":{"length":99.2,"width":60.0,"depth":40.0}}'));

    if (response.statusCode == 200) {
      // return Pothole.fromJason(jsonDecode(response.body));

    } else {
      throw Exception("Failed to load album");
    }
  }

  Future<ServiceRoute> fetchRoute() async {
    final response = await http.get("http://20.50.174.60:8080/");
    return ServiceRoute.fromJson(jsonDecode(
        '{"potholes":[{"coordinate":{"longitude":100.0,"latitude":72.2},"image":{"url":"/mein/Pfad/zum/bild.png"},"dimensions":{"length":99.2,"width":60.0,"depth":40.0,"volume":238080.0}},{"coordinate":{"longitude":800.0,"latitude":72.2},"image":{"url":"/mein/Pfad/zum/bild.png"},"dimensions":{"length":10.0,"width":10.0,"depth":10.0,"volume":1000.0}},{"coordinate":{"longitude":72.1,"latitude":20.2},"image":{"url":"/mein/Pfad/zum/bild.png"}},{"coordinate":{"longitude":90.0,"latitude":56.3},"image":{"url":"/mein/Pfad/zum/bild.png"}}]}'));
    if (response.statusCode == 200) {
      // return Pothole.fromJason(jsonDecode(response.body));

    } else {
      throw Exception("Failed to load album");
    }
  }
}
