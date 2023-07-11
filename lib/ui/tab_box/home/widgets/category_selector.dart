import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../utils/colors.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [ZoomTapAnimation(
          onTap: (){
            onCategorySelected.call("");
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.black.withOpacity(0.1),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(child: Text("All", style: TextStyle(color: Colors.black, fontSize: 20),))),
        ),
          ...List.generate(categories.length, (index) {
            return ZoomTapAnimation(
              onTap: (){
                onCategorySelected.call(categories[index]);
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
            );
          })
        ],
      ),
    );
  }
}