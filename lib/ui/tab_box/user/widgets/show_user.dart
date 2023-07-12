import 'package:flutter/material.dart';
import 'package:n8_default_project/models/user/user_model.dart';

import '../../../../utils/colors.dart';

class ShowUserScreen extends StatefulWidget {
  const ShowUserScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  State<ShowUserScreen> createState() => _ShowUserScreenState();
}

class _ShowUserScreenState extends State<ShowUserScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.C_FFF4A2,
        title: const Text("User Screen"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height*0.25, width: height*0.25, child: Icon(Icons.account_circle_sharp, size: height*0.25, color: Color(0xD7B77540),),),
            Text("${widget.userModel.nameModel.firstname} ${widget.userModel.nameModel.lastname}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 32
              ),),
            Text(widget.userModel.email, style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                fontSize: 22
            ),),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Phone number: ${widget.userModel.phone}",  style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 22
              ),)
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("City: ${widget.userModel.addressModel.city}",  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 22
                ),),
                SizedBox(width: 10,),
                Text("Street: ${widget.userModel.addressModel.street}",  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 22
                ),)
              ],),
          ],
        ),
      ),
    );
  }
}
