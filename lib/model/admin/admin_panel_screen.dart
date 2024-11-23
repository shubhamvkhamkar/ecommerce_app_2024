import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/widgets/custome_elevated_btn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AdminPanelScreenState();
}
class _AdminPanelScreenState extends State<AdminPanelScreen>{


  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct() async {

    final String name = _nameController.text.trim();
    final String price = _priceController.text.trim();
    final description = _descriptionController.text.trim();
    final String category = _categoryController.text.trim();
    final String imageUrl = _imageUrlController.text.trim();


    if(name.isEmpty || price.isEmpty ||description.isEmpty || imageUrl.isEmpty || category.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields'))
      );
      return;
    }

    try{
   await firestore.collection('products').add({
      'name' : name,
     'price' : double.parse(price),
     'category' : category,
     'image_url' : imageUrl,
     'description' : description,
     'stock' : 10
    });

   ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Product added!'))
   );
   _nameController.clear();
   _priceController.clear();
   _descriptionController.clear();
   _imageUrlController.clear();
   _categoryController.clear();
  }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Adding Product')));
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Admin panel'),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Text('Add Products',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black),),
            TextField(
            controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'description'),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image Url'),
            ),
            SizedBox(height: 20,),
            CustomeElevatedBtn(onPressed: (){
              addProduct();
            }, text: 'Add Product',
                ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
              (context) => AuthScreen(),));
            },
                child: Text('Logout admin'))
          ],
              ),
        ),
      ),
    );
  }

}