import 'package:flutter/material.dart';
import 'package:n8_default_project/data/network/api_provider.dart';
import 'package:n8_default_project/data/repositories/login_repository.dart';
import 'package:n8_default_project/ui/tab_box/tab_box.dart';

import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required this.apiProvider});
  final ApiProvider apiProvider;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  late LoginRepository loginRepository;
  @override
  void initState() {
    loginRepository = LoginRepository(apiProvider: widget.apiProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          "Ulmo",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              color: AppColors.C_212121),
        ),
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              controller: _controller1,
              decoration: InputDecoration(
                hintText: "Enter username",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ),
                  enabledBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            SizedBox(height: 40,),
            TextField(
              textInputAction: TextInputAction.done,
              controller: _controller2,
              decoration: InputDecoration(
                  hintText: "Enter password",
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                  enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            SizedBox(height: 40,),
            ElevatedButton(onPressed: () async{
              if(await loginRepository.loginUser(username: _controller1.text, password: _controller2.text)){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return TabBox(apiProvider: widget.apiProvider);
                }));
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Parol yoki username xato")));
              }
            }, child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
