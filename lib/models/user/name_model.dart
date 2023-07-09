class NameModel {
  final String firstname;
  final String lastname;

  NameModel({
    required this.lastname,
    required this.firstname,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      firstname: json['firstname'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "firstname": firstname,
      "lastname": lastname
    };
  }
}