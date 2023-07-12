import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/network/api_repository.dart';
import 'package:n8_default_project/data/repositories/category_repository.dart';
import 'package:n8_default_project/data/repositories/product_repository.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/ui/tab_box/home/sub_screen/product_add_screen.dart';
import 'package:n8_default_project/ui/tab_box/home/widgets/category_selector.dart';
import 'package:n8_default_project/ui/tab_box/home/sub_screen/show_product.dart';
import 'package:n8_default_project/utils/colors.dart';
import 'package:n8_default_project/utils/utility_functions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      required this.categoryRepository,
      required this.productRepository});
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  List<String> categories = [];
  
  String activeCategoryName = "";
  int selectedMenu = 1;
  bool isLoading = false;

  _updateProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await widget.categoryRepository
        .getCategoryProducts(categoryName: activeCategoryName);
    setState(() {
      isLoading = false;
    });
  }

  _productLimit(int limit) async{
    setState(() {
      isLoading = true;
    });
    products = await widget.productRepository
        .getAllProductsByLimit(limitCount: limit);
    setState(() {
      isLoading = false;
    });
  }

  _updateSort(String sortType) async{
    setState(() {
      isLoading = true;
    });
    products = await widget.productRepository.sortAllProducts(sortType: sortType);
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
        backgroundColor: AppColors.C_FFF4A2,
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          "Ulmo",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProductAddScreen(
                      productRepository: widget.productRepository);
                }));
              },
              icon: Icon(Icons.add)),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (int selected){
              setState(() {
                selectedMenu = selected;
              });
              if (selectedMenu == 1) {
                showDialog(context: context, builder: (context){
                  VoidCallback onTap;
                  ValueChanged<String> valueChanged;
                  TextEditingController _controller = TextEditingController();
                  return CupertinoAlertDialog(
                    content: Container(
                      height: 200,
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.all(10),
                          child: Text("Products Limit", style: TextStyle(
                              fontSize: 28,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600
                          ),),),
                          Divider(height: 2),
                          GestureDetector(
                            onTap: (){
                              _productLimit(5);
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text("5 products",style: TextStyle(
                                fontSize: 28,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600
                              ),),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _productLimit(10);
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text("10 products",style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              _productLimit(20);
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Text("20 products",style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
              } else {
                if(selectedMenu == 2){
                  _updateSort("asc");
                }else{
                  _updateSort("desc");
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Products Limit'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Sort by ASC'),
              ),
              const PopupMenuItem<int>(
                value: 3,
                child: Text('Sort by DESC'),
              ),
            ],
          )
        ],
      ),
      body: Container(
        color: AppColors.C_FFF4A2,
        child: Column(
          children: [
            CategorySelector(
              categories: categories,
              onCategorySelected: (selectedCategory) {
                activeCategoryName = selectedCategory;
                _updateProducts();
              },
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
                            crossAxisCount: 2, childAspectRatio: 0.75),
                        padding: EdgeInsets.all(10),
                        children: List.generate(
                            products.length,
                            (index) => ZoomTapAnimation(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ShowProduct(
                                        productRepository: widget.productRepository,
                                          productModel: products[index]);
                                    }));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          border: Border.all(
                                              width: 2, color: Colors.black26),
                                          color: Colors.white),
                                      height: 50,
                                      width: 50,
                                      child: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(6),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              height: 135,
                                              width: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl: products[index].image,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Text(
                                                  "\$${products[index].price.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    print("Hi");
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              products[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                )),
                      )),
          ],
        ),
      ),
    );
  }
}
