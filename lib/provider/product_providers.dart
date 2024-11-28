import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProviders with ChangeNotifier{
  List<Map<String ,dynamic>> _products = [];
  bool _isLoading = false;

  List<Map<String , dynamic>> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final snapshot =
      await FirebaseFirestore.instance.collection('products').get();
      _products = snapshot.docs.map((doc){
        return {
          ...doc.data(),
          'id' : doc.id,
        };
      }).toList();
    }catch (error){
      print('Error fetching products : $error');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Map<String , dynamic> products) async {
    try{
     await FirebaseFirestore.instance.collection('products').add(products);
      fetchProducts();
    }catch (error){
      print('Error adding products: $error');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try{
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      fetchProducts();
    }catch(error){
      print("error deleting product : $error");
    }
  }
}