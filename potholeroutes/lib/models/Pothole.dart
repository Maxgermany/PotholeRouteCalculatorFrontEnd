import 'package:potholeroutes/models/PotholeCoordinates.dart';
//import 'package:potholeroutes/models/PotholeDimensions.dart';
import 'package:potholeroutes/models/PotholeImage.dart';

class Pothole {
  PotholeCoordinates coordinate;
  //PotholeDimensions dimensions;
  PotholeImage image;

  Pothole({this.coordinate, this.image});

  factory Pothole.fromJson(Map<String, dynamic> json) {
    return new Pothole(
      coordinate: PotholeCoordinates.fromJson(json['coordinate']),
      image: PotholeImage.fromJson(json['image']),
    );
  }

}
