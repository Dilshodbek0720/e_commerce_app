import 'package:flutter/material.dart';
import 'package:n8_default_project/data/local/storage_repository.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/repositories/user_repository.dart';
import 'package:n8_default_project/models/user/user_model.dart';
import 'package:n8_default_project/ui/login/login_screen.dart';
import 'package:n8_default_project/ui/tab_box/user/widgets/show_user.dart';

import '../../../utils/colors.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key, required this.userRepository});
  final UserRepository userRepository;
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isLoading = false;
  List<UserModel> users = [];
  _getUsers() async {
    setState(() {
      isLoading = true;
    });
    users = await widget.userRepository
        .getAllUsers();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    _getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 60,
      centerTitle: true,
        backgroundColor: AppColors.C_FFF4A2,
      title: const Text(
        "Users",
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
            color: AppColors.C_212121),
      ),
        actions: [
          IconButton(onPressed: (){
            StorageRepository.deleteString("token");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return LoginScreen(apiProvider: ApiProvider());
            }));
          }, icon: Icon(Icons.delete, color: Colors.black,))
        ],
    ),
      body: isLoading
          ? const Center(
          child: CircularProgressIndicator(),
      )
          : users.isEmpty
          ? const Center(child: Text("Xatolik sodir bo'ldi"))
          : ListView(
        children: List.generate(users.length, (index) {
          UserModel userModel = users[index];
          return Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ShowUserScreen(userModel: userModel);
                  }));
                },
                trailing: IconButton(onPressed: () { } , icon: Icon(Icons.account_circle_sharp, size: 35,)),
                title: Text("${userModel.nameModel.firstname} ${userModel.nameModel.lastname}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 20
                ),),
                subtitle: Text(userModel.username, style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 15
                ),),
              ),
              Divider(height: 2,)
            ],
          );
        }),
      )
    );
  }
}
