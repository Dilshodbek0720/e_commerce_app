import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n8_default_project/data/repositories/category_repository.dart';
import 'package:n8_default_project/data/repositories/product_repository.dart';
import 'package:n8_default_project/data/repositories/user_repository.dart';
import 'package:n8_default_project/ui/tab_box/home/home_screen.dart';
import 'package:n8_default_project/ui/tab_box/like/like_screen.dart';
import 'package:n8_default_project/ui/tab_box/user/user_screen.dart';
import 'package:n8_default_project/utils/icons.dart';

import '../../data/network/api_provider.dart';
import 'bag/bag_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key, required this.apiProvider}) : super(key: key);
  final ApiProvider apiProvider;
  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;
  late ProductRepository productRepository;
  late UserRepository userRepository;
  late CategoryRepository categoryRepository;

  List<Widget> screens = [];

  @override
  void initState() {
    productRepository = ProductRepository(apiProvider: widget.apiProvider);
    categoryRepository = CategoryRepository(apiProvider: widget.apiProvider);
    userRepository = UserRepository(apiProvider: widget.apiProvider);
    screens.add(HomeScreen(productRepository: productRepository,categoryRepository: categoryRepository),);
    screens.add(BagScreen());
    screens.add(LikesScreen());
    screens.add(UserScreen(userRepository: userRepository));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 24,
        onTap:
            (index) {
          setState(() {
            currentIndex = index;
          });
          switch(currentIndex){
            case 0:{}
            break;
          }
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.green),
        items: [
          getItem(icon: AppImages.uIcon, labelText: "Home"),
          getItem(icon: AppImages.bagIcon, labelText: "Bag"),
          getItem(icon: AppImages.likeIcon, labelText: "Like"),
          getItem(icon: AppImages.contactIcon, labelText: "Contact")
        ],
      ),
    );
  }

  BottomNavigationBarItem getItem(
      {required String icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: SvgPicture.asset(icon, color: Colors.black.withOpacity(0.3),),
        activeIcon: SvgPicture.asset(icon, color: Colors.black.withOpacity(0.8),));
  }
}