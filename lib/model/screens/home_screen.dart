import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/provider/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';
import '../../provider/cart_provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProviders>(context,listen: false).fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Drawer(
          width: 100,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
              (context) => AuthScreen(),));
            },
            child: Text('LogOut'),),
        ),
        title: Text('E-Com 2024'),
        actions: [
          IconButton(onPressed: (){
            /*Navigator.push(context, MaterialPageRoute(builder:
            (context) => CartScreen(),
            ));*/
          },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Consumer<ProductProviders>(
        builder: (
            context,
            productProvider ,
            child) {
          if(productProvider.products.isEmpty){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (ctx, index) {
              final product = productProvider.products[index];
              return ListTile(
                leading: Image.network(product['image_url']),
                title: Text(product['name']),
                subtitle: Text("₹${product['price']}"),
                trailing: IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: (){
                    Provider.of<CartProvider>(context,listen: false).addItem(product['id']);
                  },
                ),

              );

          },);
        },

      ),
    );
  }

}