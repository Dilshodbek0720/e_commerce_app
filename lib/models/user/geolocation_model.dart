class GeolocationModel {
  final String lat;
  final String long;

  GeolocationModel({
    required this.lat,
    required this.long,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) {
    return GeolocationModel(
      lat: json['lat'] as String? ?? "",
      long: json['long'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "lat":lat,
      "long":long
    };
  }
}