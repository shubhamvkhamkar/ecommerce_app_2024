import 'package:ecommerce_app_2024/model/screens/fav_screen.dart';
import 'package:ecommerce_app_2024/provider/favorites_provider.dart';
import 'package:ecommerce_app_2024/widgets/custome_elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';


class ProductDetailScreen extends StatelessWidget {

  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});



  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isFavorite = Provider.of<FavoritesProvider>(context).isFavorite(product);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 75,
        actions: [
          IconButton(onPressed: (){
            if(isFavorite){
              Provider.of<FavoritesProvider>(context,listen: false).removeFavorite(product);
            }else {
              Provider.of<FavoritesProvider>(context, listen: false).addFavorite(product);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added to Favorites')));
          }, icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
          ))
        ],
        title: Text(product['name']),
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(product['image_url']),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(product['description']),
              ),
              Text('Price : ${product['price']}', style: TextStyle(fontSize: 24),),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomeElevatedBtn(onPressed: (){
                  cartProvider.addItem(product['id'],product['price'],product['name']);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added to cart')));

                },
                    text: 'Add To Cart',
                    /*child: Text('Add to cart')*/ ),
              )
            ],
          ),
        ),

    );
  }
}