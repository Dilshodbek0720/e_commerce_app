import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/models/universal_response.dart';
import 'package:n8_default_project/models/user/user_model.dart';

class ApiProvider {

  Future<UniversalResponse> getAllProductsByLimit({required int limitCount})async{
    Uri uri = Uri.parse("https://fakestoreapi.com/products?limit=$limitCount");
    try{
      http.Response response = await http.get(uri);

      if(response.statusCode == 200){
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)?.map((e) => ProductModel.fromJson(e)).toList()??[]
        );
      }
      return UniversalResponse(error: "ERROR");
    }catch(error){
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> getAllProducts() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => ProductModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> getProductById({
    required int productId
}) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products/$productId");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return UniversalResponse(
          data: ProductModel.fromJson(jsonData)
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> newAddProduct({required ProductModel addProduct}) async{
    Uri uri = Uri.parse("https://fakestoreapi.com/products");
    try{
      http.Response response = await http.post(uri, body: {
        "title": addProduct.title,
        "price": addProduct.price,
        "description": addProduct.description,
        "image": addProduct.image,
        "category": addProduct.category
      });
      if(response.statusCode == 200){
        return UniversalResponse(
          data: ProductModel.fromJson(jsonDecode(response.body))
        );
      }else{
        return UniversalResponse(error: "ERROR");
      }
    }catch(error){
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> addProductUpdate({required int updateId, required ProductModel updateModel}) async{
    Uri uri = Uri.parse("https://fakestoreapi.com/products$updateId");
    try{
      http.Response response = await http.put(uri, body: {
        "title": updateModel.title,
        "price": updateModel.price,
        "description": updateModel.description,
        "image": updateModel.image,
        "category": updateModel.category
      });
      if(response.statusCode == 200){
        return UniversalResponse(
            data: ProductModel.fromJson(jsonDecode(response.body))
        );
      }else{
        return UniversalResponse(error: "ERROR");
      }
    }catch(error){
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> delateProduct({
    required int deleteId
  }) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products/$deleteId");
    try {
      http.Response response = await http.delete(uri);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        return UniversalResponse(
            data: ProductModel.fromJson(jsonData)
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }


  Future<UniversalResponse> sortAllProducts({required String sortType}) async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products?sort=$sortType");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
              ?.map((e) => ProductModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> getAllCategoryProducts() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/products/categories");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
              ?.map((e) => e as String)
              .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> getCategoryProducts(
      {required String categoryName}) async {
    Uri url = Uri.parse(
      categoryName.isNotEmpty
          ? 'https://fakestoreapi.com/products/category/$categoryName'
          : "https://fakestoreapi.com/products",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
                []);
      }
      return UniversalResponse(error: 'Error: Status code not equal to 200');
    } catch (e) {
      print(e);
      return UniversalResponse(error: e.toString());
    }
  }

  // Future<UniversalResponse> getCategoryProducts({required String categoryName}) async {
  //   Uri uri = Uri.parse("https://fakestoreapi.com/products/category/$categoryName");
  //   try {
  //     http.Response response = await http.get(uri);
  //
  //     if (response.statusCode == 200) {
  //       return UniversalResponse(
  //         data: (jsonDecode(response.body) as List?)
  //             ?.map((e) => ProductModel.fromJson(e))
  //             .toList() ??
  //             [],
  //       );
  //     }
  //     return UniversalResponse(error: "ERROR");
  //   } catch (error) {
  //     return UniversalResponse(error: error.toString());
  //   }
  // }

  Future<UniversalResponse> getAllUsers() async {
    Uri uri = Uri.parse("https://fakestoreapi.com/users");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }

  Future<UniversalResponse> loginUser({required String username, required String password}) async{
    Uri uri = Uri.parse("https://fakestoreapi.com/auth/login");
    try{
      http.Response response = await http.post(uri, body: {"username": username, "password": password});

      if(response.statusCode == 200){
        return UniversalResponse(
          data: jsonDecode(response.body)['token']
        );
      }
      return UniversalResponse(error: "ERROR");
    }catch(error){
      return UniversalResponse(error: error.toString());
    }
  }

}
