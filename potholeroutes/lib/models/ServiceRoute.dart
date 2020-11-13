import 'package:potholeroutes/models/Pothole.dart';

class ServiceRoute {
  List<Pothole> potholes;

  ServiceRoute({this.potholes});

  factory ServiceRoute.fromJson(Map<String, dynamic> json) {
    var routes = json['potholes']
        .map((potholeJson) => Pothole.fromJson(potholeJson))
        .toList()
        .cast<Pothole>();

    return ServiceRoute(potholes: routes);
  }
}
