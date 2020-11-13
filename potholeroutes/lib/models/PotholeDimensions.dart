class PotholeDimensions {
  double length;
  double width;
  double depth;

  PotholeDimensions({this.length, this.width, this.depth});

  factory PotholeDimensions.fromJason(Map<String, dynamic> json) {
    return PotholeDimensions(
      length: json['length'],
      width: json['width'],
      depth: json['depth'],
    );
  }
}
