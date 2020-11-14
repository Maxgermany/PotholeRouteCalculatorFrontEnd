import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:potholeroutes/models/PotholeAddress.dart';
import 'package:potholeroutes/models/PotholeCoordinates.dart';

class GeolocationService {
  Future<PotholeAddress> fetchPotholeAddress(
      PotholeCoordinates coordinates) async {
    try {
      String getLink =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=" +
              coordinates.latitude.toString() +
              "," +
              coordinates.longitude.toString() +
              "&key=AIzaSyC38yB81u25a2vvtsJGvGoWd6weOGaPx1A";

      final response = await http.get(getLink);

      //return PotholeAddress.fromJson(jsonDecode(
      //    '{"formatted_address": "Am Hauptplatz 3"}'));

      if (response.statusCode == 200) {
        return PotholeAddress.fromJson(jsonDecode(response.body));
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
