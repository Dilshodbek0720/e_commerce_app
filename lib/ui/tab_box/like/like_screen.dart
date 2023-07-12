import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: AppColors.C_FFF4A2,
        title: const Text(
          "Likes",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
      ),
    );
  }
}
