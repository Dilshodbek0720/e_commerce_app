import 'package:flutter/material.dart';
import 'package:n8_default_project/data/repositories/category_repository.dart';
import 'package:n8_default_project/data/repositories/product_repository.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/ui/tab_box/home/widgets/category_selector.dart';
import 'package:n8_default_project/ui/tab_box/home/widgets/show_product.dart';
import 'package:n8_default_project/utils/colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.productRepository, required this.categoryRepository});
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String activeCategoryName = "";
  List<String> categories = [];
  List<ProductModel> products = [];
  int categoryId = 0;
  bool isLoading = false;

  _updateProducts() async {
    setState(() {
      isLoading = true;
    });
    products =
    await widget.categoryRepository.getCategoryProducts(categoryName: activeCategoryName);
    setState(() {
      isLoading = false;
    });
  }

  _init() async {
    categories = await widget.categoryRepository.getAllCategoryProducts();
  }

  @override
  void initState() {
    _init();
    _updateProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          "Ulmo",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
      ),
      body: Column(
                  children: [
                    categories.isNotEmpty
                        ? CategorySelector(
                      categories: categories,
                      onCategorySelected: (selectedCategory) {
                        activeCategoryName = selectedCategory;
                        _updateProducts();
                      },
                    )
                        : const Center(child: CircularProgressIndicator()),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10),
                    //   height: 40,
                    //   width: double.infinity,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     children: List.generate(categories.length, (index) => ZoomTapAnimation(
                    //       onTap: (){
                    //         setState(() {
                    //           categoryId = index;
                    //           _fetchData();
                    //         });
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(horizontal: 12),
                    //         height: 40,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: AppColors.black.withOpacity(0.1),
                    //         ),
                    //         margin: EdgeInsets.symmetric(horizontal: 10),
                    //           child: Center(child: Text(categories[index], style: TextStyle(color: Colors.black, fontSize: 20),))),
                    //     )),
                    //   ),
                    // ),
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ShowProduct(productModel: products[index],);
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(products[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                    fontSize: 14,
                                  ),),
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
