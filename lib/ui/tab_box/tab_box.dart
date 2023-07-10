import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n8_default_project/data/network/api_repository.dart';
import 'package:n8_default_project/ui/tab_box/basket/basket_screen.dart';
import 'package:n8_default_project/ui/tab_box/contact/contact_screen.dart';
import 'package:n8_default_project/ui/tab_box/home/home_screen.dart';
import 'package:n8_default_project/ui/tab_box/like/like_screen.dart';
import 'package:n8_default_project/utils/icons.dart';

import '../../data/network/api_provider.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  final CommercialRepository commercialRepository = CommercialRepository(apiProvider: ApiProvider());


  List<Widget> screens = [];

  @override
  void initState() {

    screens = [
      HomeScreen(),
      BasketScreen(),
      LikesScreen(),
      ContactScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:screens[currentIndex],
      // IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
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