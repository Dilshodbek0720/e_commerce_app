import '../../models/universal_response.dart';
import '../../models/user/user_model.dart';
import '../network/api_provider.dart';

class UserRepository{
  final ApiProvider apiProvider;
  UserRepository({required this.apiProvider});

  Future<List<UserModel>> getAllUsers() async {
    UniversalResponse universalResponse = await apiProvider.getAllUsers();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<UserModel>;
    }
    return [];
  }
}