import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/network/api_repository.dart';

import '../../models/currency_model.dart';

class CurrenciesScreen1 extends StatefulWidget {
  const CurrenciesScreen1({Key? key}) : super(key: key);

  @override
  State<CurrenciesScreen1> createState() => _CurrenciesScreen1State();
}

class _CurrenciesScreen1State extends State<CurrenciesScreen1> {
  final CurrencyRepository currencyRepository =
      CurrencyRepository(apiProvider: ApiProvider());

  List<CurrencyModel> currencies = [];

  bool isLoading = false;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    currencies = await currencyRepository.fetchCurrencies();
    print("CURRENCY FETCH FINISHED:${currencies.length}");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currencies Screen"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : currencies.isEmpty
              ? const Center(child: Text("Xatolik sodir bo'ldi"))
              : ListView(
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
                ),
    );
  }
}
