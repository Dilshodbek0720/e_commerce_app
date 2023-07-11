import '../../models/products/product_model.dart';
import '../../models/universal_response.dart';
import '../network/api_provider.dart';

class CategoryRepository{
  final ApiProvider apiProvider;
  CategoryRepository({required this.apiProvider});

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
}