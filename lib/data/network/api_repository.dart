import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/models/universal_response.dart';
import 'package:n8_default_project/models/user/user_model.dart';

class CommercialRepository {
  final ApiProvider apiProvider;

  CommercialRepository({required this.apiProvider});

  Future<List<ProductModel>> getAllProducts() async {
    UniversalResponse universalResponse = await apiProvider.getAllProducts();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> getAllProductsByLimit({required limitCount}) async {
    UniversalResponse universalResponse = await apiProvider.getAllProductsByLimit(limitCount: limitCount);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<ProductModel> getSingleProduct({required int productId})async{
    UniversalResponse universalResponse = await apiProvider.getProductById(productId: productId);
    if (universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    throw Exception();
  }

  Future<ProductModel> newAddProduct({required ProductModel addProduct}) async{
    UniversalResponse universalResponse = await apiProvider.newAddProduct(addProduct: addProduct);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    throw Exception();
  }

  Future<ProductModel> addProductUpdate({required int updateId, required ProductModel updateModel}) async{
    UniversalResponse universalResponse = await apiProvider.addProductUpdate(updateId: updateId, updateModel: updateModel);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    throw Exception();
  }

  Future<ProductModel> delateProduct({required int deleteId}) async{
    UniversalResponse universalResponse = await apiProvider.delateProduct(deleteId: deleteId);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    throw Exception();
  }

  Future<List<ProductModel>> sortAllProducts({required String sortType}) async {
    UniversalResponse universalResponse = await apiProvider.sortAllProducts(sortType: sortType);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<String>> getAllCategoryProducts() async {
    UniversalResponse universalResponse = await apiProvider.getAllCategoryProducts();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<String>;
    }
    return [];
  }

  Future<List<ProductModel>> getCategoryProducts({required String categoryName}) async {
    UniversalResponse universalResponse = await apiProvider.getCategoryProducts(categoryName: categoryName);
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<ProductModel>;
    }
    return [];
  }

  Future<List<UserModel>> getAllUsers() async {
    UniversalResponse universalResponse = await apiProvider.getAllUsers();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserModel>;
    }
    return [];
  }

  Future<String> loginUser({required String username, required String password}) async{
    UniversalResponse universalResponse = await apiProvider.loginUser(username: username, password: password);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as String;
    }
    return "";
  }
}
