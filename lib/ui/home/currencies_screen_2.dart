import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/network/api_repository.dart';

import '../../models/currency_model.dart';

class CurrenciesScreen2 extends StatefulWidget {
  const CurrenciesScreen2({Key? key}) : super(key: key);

  @override
  State<CurrenciesScreen2> createState() => _CurrenciesScreen2State();
}

class _CurrenciesScreen2State extends State<CurrenciesScreen2> {
  final CurrencyRepository currencyRepository =
      CurrencyRepository(apiProvider: ApiProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currencies Screen"),
      ),
      body: FutureBuilder<List<CurrencyModel>>(
        future: currencyRepository.fetchCurrencies(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CurrencyModel>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<CurrencyModel> currencies = snapshot.data!;
            return currencies.isNotEmpty
                ? ListView(
                    children: List.generate(
                      currencies.length,
                      (index) {
                        CurrencyModel currency = currencies[index];
                        return ListTile(
                          onTap: () {},
                          title: Text(currency.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Qiymat:${currency.cbPrice}"),
                              Text("Date:${currency.date}"),
                            ],
                          ),
                          trailing: Text(currency.code),
                        );
                      },
                    ),
                  )
                : const Center(child: Text("Xatolik sodir bo'ldi"));
          }
          return Center(child: Text("Error:${snapshot.error}"));
        },
      ),
    );
  }
}
