import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/network/api_repository.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/models/user/user_model.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CommercialRepository commercialRepository = CommercialRepository(apiProvider: ApiProvider());

  List<ProductModel> products = [];
  bool isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    products = await commercialRepository.getCategoryProducts(categoryName: "jewelery");
    print("CURRENCY FETCH FINISHED:${products.length}");
    String user = await commercialRepository.loginUser(username: "mor_2314", password: "83r5^_");
    print(user);
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
        title: Text("Products"),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : products.isEmpty
          ? const Center(child: Text("Xatolik sodir bo'ldi"))
          : Container(
            child: ListView(
        children: List.generate(
            products.length,
                (index) {
              ProductModel product = products[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                ),
              );
            },
        ),
      ),
          ),
    );
  }
}
