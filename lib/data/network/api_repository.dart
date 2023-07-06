import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/models/currency_model.dart';
import 'package:n8_default_project/models/universal_response.dart';

class CurrencyRepository {
  final ApiProvider apiProvider;

  CurrencyRepository({required this.apiProvider});

  Future<List<CurrencyModel>> fetchCurrencies() async {
    UniversalResponse universalResponse = await apiProvider.getAllCurrencies();
    if (universalResponse.error.isEmpty) {
      return universalResponse.data as List<CurrencyModel>;
    }
    return [];
  }
}
