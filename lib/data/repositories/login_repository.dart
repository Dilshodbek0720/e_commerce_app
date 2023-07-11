import '../../models/universal_response.dart';
import '../network/api_provider.dart';

class LoginRepository{
  final ApiProvider apiProvider;
  LoginRepository({required this.apiProvider});

  Future<String> loginUser({required String username, required String password}) async{
    UniversalResponse universalResponse = await apiProvider.loginUser(username: username, password: password);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as String;
    }
    return "";
  }
}