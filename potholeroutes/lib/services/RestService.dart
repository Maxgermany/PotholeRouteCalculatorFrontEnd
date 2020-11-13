import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:potholeroutes/models/Pothole.dart';

class RestService {
  Future<Pothole> fetchPothole() async {
    final response = await http.get("http://20.50.174.60:8080/");

    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception("Failed to load album");
    }
  }
}
