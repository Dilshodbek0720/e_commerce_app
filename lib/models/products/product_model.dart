import 'package:n8_default_project/models/products/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final RatingModel ratingModel;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ratingModel
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      price: json["price"] as num? ?? 0.0,
      description: json["description"] as String? ?? "",
      category: json["category"] as String? ?? "",
      image: json["image"] as String? ?? "",
      ratingModel: RatingModel.fromJson(json["rating"])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "title":title,
      "price":price,
      "description":description,
      "category":category,
      "image":image
    };
  }
}
