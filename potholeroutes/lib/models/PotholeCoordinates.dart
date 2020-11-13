class PotholeCoordinates {
  double longitude;
  double latitude;

  PotholeCoordinates({this.latitude, this.longitude});

  factory PotholeCoordinates.fromJason(Map<String, dynamic> json) {
    return PotholeCoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
