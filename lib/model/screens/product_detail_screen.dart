import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';


class ProductDetailScreen extends StatelessWidget {

  final Map<String , dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Column(
        children: [
          Image.network(product['image_url']),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(product['description']),
          ),
          Text('Price : ${product['price']}', style: TextStyle(fontSize: 24),),
          ElevatedButton(onPressed: (){
            cartProvider.addItem(product['id']);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added to cart')));

          },
              child: Text('Add to cart') )
        ],
      ),
    );
  }
}