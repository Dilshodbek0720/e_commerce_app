import 'package:n8_default_project/data/local/storage_repository.dart';

import '../../models/universal_response.dart';
import '../network/api_provider.dart';

class LoginRepository{
  final ApiProvider apiProvider;
  LoginRepository({required this.apiProvider});

  Future<bool> loginUser({required String username, required String password}) async{
    UniversalResponse universalResponse = await apiProvider.loginUser(username: username, password: password);
    if(universalResponse.error.isEmpty){
      await StorageRepository.putString("token", universalResponse.data as String);
      return true;
    }
    return false;
  }
}