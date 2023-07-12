import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: AppColors.C_FFF4A2,
        title: const Text(
          "Bag",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
      ),
    );
  }
}
