import 'package:flutter/material.dart';
import 'package:n8_default_project/data/repositories/user_repository.dart';

import '../../../utils/colors.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.userRepository});
  final UserRepository userRepository;
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 60,
      centerTitle: true,
      title: const Text(
        "User",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
            color: AppColors.C_212121),
      ),
    ),
    );
  }
}
