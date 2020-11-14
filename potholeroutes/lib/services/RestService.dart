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
        '{"potholes":[{"coordinate":{"latitude":51.5000379,"longitude":9.9806003},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"},"dimensions":{"length":1000.2,"width":60.0,"depth":40.0,"volume":2400480.0}},{"coordinate":{"latitude":51.5010379,"longitude":9.9801803},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"}},{"coordinate":{"latitude":51.501200379,"longitude":9.9812803},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"}},{"coordinate":{"latitude":51.5030379,"longitude":9.9830803},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"},"dimensions":{"length":10.0,"width":10.0,"depth":10.0,"volume":1000.0}},{"coordinate":{"latitude":51.5047379,"longitude":9.9807803},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"},"dimensions":{"length":99.2,"width":60.0,"depth":40.0,"volume":238080.0}},{"coordinate":{"latitude":51.5040379,"longitude":9.9800803},"image":{"url":"https://upload.wikimedia.org/wikipedia/commons/3/3a/Schlagloch3.06.jpg"}}]}'));
    if (response.statusCode == 200) {
      // return Pothole.fromJason(jsonDecode(response.body));

    } else {
      throw Exception("Failed to load album");
    }
  }

  void potholeFixed(Pothole pothole) {}
}
