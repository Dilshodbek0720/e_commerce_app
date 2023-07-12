import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n8_default_project/data/repositories/product_repository.dart';
import 'package:n8_default_project/models/products/product_model.dart';
import 'package:n8_default_project/ui/tab_box/home/sub_screen/update_screen.dart';
import 'package:n8_default_project/utils/colors.dart';
import 'package:n8_default_project/utils/icons.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({super.key, required this.productModel, required this.productRepository});
  final ProductModel productModel;
  final ProductRepository productRepository;
  @override
  State<ShowProduct> createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFFF4A2),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFF4A2),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(AppImages.arrowLeft),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProductUpdateScreen(productRepository: widget.productRepository, productModel: widget.productModel);
              }));
            },
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(AppImages.settingsIcon),
              ),
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(AppImages.likeIcon),
              ),
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: height*0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.white
              ),
              width: double.infinity,
              child: Image.network(widget.productModel.image),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                SizedBox(width: 30,),
                Text("\$${widget.productModel.price}", style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),),
              ],
            ),
            SizedBox(height: 6,),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("\$${widget.productModel.title}",
              maxLines: 4,
              style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),),
            ),
            SizedBox(height: 6,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("\$${widget.productModel.description}",
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){}, child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add to bag", style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                  ),),
                  SizedBox(width:10,),
                  SvgPicture.asset(AppImages.bagButtonIcon,)
                ],
              ),
            )),
            SizedBox(height: 35,)
          ],
        ),
      ),
    );
  }
}
