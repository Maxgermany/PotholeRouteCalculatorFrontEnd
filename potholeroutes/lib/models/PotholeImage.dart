class PotholeImage {
  String imageUrl;

  PotholeImage({this.imageUrl});

  factory PotholeImage.fromJason(Map<String, dynamic> json) {
    return PotholeImage(
      imageUrl: json['url'],
    );
  }
}
