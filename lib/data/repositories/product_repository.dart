import '../../models/products/product_model.dart';
import '../../models/universal_response.dart';
import '../network/api_provider.dart';

class ProductRepository{
  final ApiProvider apiProvider;
  ProductRepository({required this.apiProvider});

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

  Future<ProductModel?> newAddProduct({required ProductModel addProduct}) async{
    UniversalResponse universalResponse = await apiProvider.newAddProduct(addProduct: addProduct);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    return null;
  }

  Future<ProductModel?> addProductUpdate({required int updateId, required ProductModel updateModel}) async{
    UniversalResponse universalResponse = await apiProvider.addProductUpdate(updateId: updateId, updateModel: updateModel);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as ProductModel;
    }
    return null;
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

}