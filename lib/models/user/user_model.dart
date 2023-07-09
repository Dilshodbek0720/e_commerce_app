import 'package:n8_default_project/models/user/address_model.dart';
import 'package:n8_default_project/models/user/name_model.dart';

class UserModel {
  final AddressModel addressModel;
  final NameModel nameModel;
  final int id;
  final String email;
  final String username;
  final String password;
  final String phone;
  final int vvv;

  UserModel(
      {required this.addressModel,
      required this.nameModel,
      required this.id,
      required this.email,
      required this.username,
      required this.password,
      required this.phone,
      required this.vvv});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      addressModel: AddressModel.fromJson(json['address']),
      nameModel: NameModel.fromJson(json['name']),
      id: json['id'] as int? ?? 0,
      email: json['email'] as String? ?? "",
      username: json['username'] as String? ?? "",
      password: json['password'] as String? ?? "",
      phone: json['phone'] as String? ?? "",
      vvv: json['__v'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "address":addressModel.toJson(),
      "name":nameModel.toJson(),
      "id":id,
      "email":email,
      "username":username,
      "password":password,
      "phone":phone,
      "__v":vvv,
    };
  }
}
