import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n8_default_project/data/repositories/product_repository.dart';
import 'package:n8_default_project/utils/colors.dart';

import '../../../../models/products/product_model.dart';
import '../../../../models/products/rating_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/utility_functions.dart';
import '../../../../widgets/global_button.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key, required this.productRepository});

  final ProductRepository productRepository;

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String imagePath = defaultImageConstant;
  String dropdownValue = categoriesForAdd.first;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.C_FFF4A2,
        appBar: AppBar(
          backgroundColor: AppColors.C_FFF4A2,
          title: const Text("Add Screen"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 24),
                  TextField(
                    controller: titleController,
                    decoration: getTextFieldDecoration("Title"),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    decoration: getTextFieldDecoration("Price"),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: descriptionController,
                    decoration: getTextFieldDecoration("Description"),
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField(
                    decoration: getTextFieldDecoration("Select Category"),
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: categoriesForAdd
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        showBottomSheetDialog();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: imagePath == defaultImageConstant
                          ? Text(
                        imagePath,
                        style: const TextStyle(color: Colors.deepPurple),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                          : Image.file(
                        File(imagePath),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalButton(
                text: "Add Product",
                onTap: () async {
                  if (titleController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      imagePath != defaultImageConstant) {
                    ProductModel? product = await widget.productRepository.newAddProduct(
                      addProduct: ProductModel(
                        id: 0,
                        title: titleController.text,
                        price: double.parse(priceController.text),
                        description: descriptionController.text,
                        category: dropdownValue,
                        image: imagePath,
                        ratingModel: RatingModel(
                          rate: 0,
                          count: 0,
                        ),
                      ),
                    );
                    if (product == null) {
                      showCustomMessage(context, "Product Added");
                      Navigator.pop(context);
                    } else {
                      showCustomMessage(context, "Something went wrong!!!");
                    }
                  } else {
                    showCustomMessage(
                        context, "Enter valid data for product add!!!");
                  }
                }),
            const SizedBox(height: 20),
          ],
        ));
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      setState(() {
        imagePath = xFile.path;
      });
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      setState(() {
        imagePath = xFile.path;
      });
    }
  }
}