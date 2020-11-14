class PotholeAddress {

  String address;

  PotholeAddress({this.address});

  factory PotholeAddress.fromJson(Map<String, dynamic> json) {
    return new PotholeAddress(
      address: json['results'][0]['formatted_address'],
    );
  }

  getStreetName(){
    String streetWithNumber = address.split(',')[0];
    String street = streetWithNumber.split(" ")[0];
    return street;
  }
}
