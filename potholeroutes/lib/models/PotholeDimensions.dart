class PotholeDimensions {
  double length;
  double width;
  double depth;

  PotholeDimensions({this.length, this.width, this.depth});

  factory PotholeDimensions.fromJson(Map<String, dynamic> json) {
    return PotholeDimensions(
      length: json['length'],
      width: json['width'],
      depth: json['depth'],
    );
  }
}
