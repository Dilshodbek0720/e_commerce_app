import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/network/api_repository.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommercialRepository commercialRepository =
      CommercialRepository(apiProvider: ApiProvider());
  
  List<String> categories = [];
  List<ProductModel> products = [];
  int categoryId = 0;
  bool isLoading = false;
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    categories = await commercialRepository.getAllCategoryProducts();
    products = await commercialRepository.getCategoryProducts(
        categoryName: categories[categoryId]);
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
        centerTitle: true,
        toolbarHeight: 80,
        title: const Text(
          "Ulmo",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
      ),
      body: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 40,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(categories.length, (index) => ZoomTapAnimation(
                          onTap: (){
                            setState(() {
                              categoryId = index;
                              _fetchData();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.black.withOpacity(0.1),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(child: Text(categories[index], style: TextStyle(color: Colors.black, fontSize: 20),))),
                        )),
                      ),
                    ),
                    isLoading
                        ? Expanded(
                          child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                        )
                        : products.isEmpty
                        ? const Center(child: Text("Xatolik sodir bo'ldi"))
                        : Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7
                        ),
                        padding: EdgeInsets.all(10),
                        children: List.generate(products.length, (index) => ZoomTapAnimation(
                          onTap: (){ },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(width: 2, color: Colors.black26),
                              color: Colors.white
                            ),
                            height: 50,
                            width: 50,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                                    height: 150,
                                    width: double.infinity,
                                    child: Image.network(products[index].image)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text("\$${products[index].price.toString()}", style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black
                                      ),),
                                    ),
                                    Spacer(),
                                    IconButton(onPressed: (){
                                      print("Hi");
                                    }, icon: Icon(Icons.favorite_outline, color: Colors.red,))
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(products[index].title, style: TextStyle(
                                      fontSize: 9.5,
                                    ),),
                                  ),
                                ),
                              ],
                            )
                          ),
                        )),
                      )
                    ),
                  ],
                ),
    );
  }
}
