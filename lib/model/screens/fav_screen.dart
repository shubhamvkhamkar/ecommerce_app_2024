import 'package:ecommerce_app_2024/model/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../provider/favorites_provider.dart';
import '../../provider/product_providers.dart';

class FavScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourait list',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 75,
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: ListView.separated(
        itemCount: favorites.length,
          itemBuilder: (ctx, index) {
            final product = favorites[index];
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product),));

              },
              leading: Image.network(product['image_url'],height: 100,width: 100,),
              title: Text(product['name'],),
              subtitle: Text('${product['price']}'),
              trailing: IconButton(
                onPressed: (){
                  Provider.of<FavoritesProvider>(context,listen: false).removeFavorite(product);
                },
                 icon: Icon(Icons.remove_shopping_cart) ,
              ),
            );
          },

        separatorBuilder: (context, index) => Divider(
          height: 10,
        ), )
    );

  }

}