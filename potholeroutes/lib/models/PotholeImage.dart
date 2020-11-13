class PotholeImage {
  String imageUrl;

  PotholeImage({this.imageUrl});

  factory PotholeImage.fromJson(Map<String, dynamic> json) {
    return PotholeImage(
      imageUrl: json['url'],
    );
  }
}
