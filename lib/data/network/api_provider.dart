import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:n8_default_project/models/currency_model.dart';
import 'package:n8_default_project/models/universal_response.dart';

class ApiProvider {
  Future<UniversalResponse> getAllCurrencies() async {
    Uri uri = Uri.parse("https://nbu.uz/en/exchange-rates/json/");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
          data: (jsonDecode(response.body) as List?)
                  ?.map((e) => CurrencyModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return UniversalResponse(error: "ERROR");

    } catch (error) {
      print("ERRROR$error");
      return UniversalResponse(error: error.toString());
    }
  }
}
