import 'package:potholeroutes/models/PotholeCoordinates.dart';
import 'package:potholeroutes/models/PotholeDimensions.dart';
import 'package:potholeroutes/models/PotholeImage.dart';

class Pothole {
  PotholeCoordinates coordinate;
  PotholeDimensions dimensions;
  PotholeImage image;

  Pothole({this.coordinate, this.dimensions, this.image});

  factory Pothole.fromJason(Map<String, dynamic> json) {
    return new Pothole(
      coordinate: PotholeCoordinates.fromJason(json['coordinate']),
      dimensions: PotholeDimensions.fromJason(json['dimension']),
      image: PotholeImage.fromJason(json['image']),
    );
  }
}
