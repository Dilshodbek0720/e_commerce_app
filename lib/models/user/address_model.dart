import 'geolocation_model.dart';

class AddressModel {
  GeolocationModel geolocationModel;
  String city;
  String street;
  int number;
  String zipcode;

  AddressModel({
    required this.geolocationModel,
    required this.street,
    required this.number,
    required this.city,
    required this.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json){
    return AddressModel(
        geolocationModel: GeolocationModel.fromJson(json['geolocation']),
        street: json["street"] as String? ?? "",
        number: json["number"] as int? ?? 0,
        city: json["city"] as String? ?? "",
        zipcode: json["zipcode"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "geolocation":geolocationModel.toJson(),
      "city":city,
      "street":street,
      "number":number,
      "zipcode":zipcode,
    };
  }

}