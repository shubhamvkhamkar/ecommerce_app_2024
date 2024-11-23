import 'package:ecommerce_app_2024/model/authentication/auth_screen.dart';
import 'package:ecommerce_app_2024/model/screens/product_detail_screen.dart';
import 'package:ecommerce_app_2024/provider/product_providers.dart';
import 'package:ecommerce_app_2024/widgets/home_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '';
import '../../provider/cart_provider.dart';
import 'cart_screen.dart';

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
    final user = FirebaseAuth.instance.currentUser;
    /*Provider.of<ProductProviders>(context,listen: false).fetchProducts();*/
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('E-Com 2024',style: TextStyle(fontWeight: FontWeight.bold),),

        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:
            (context) => CartScreen(),
            ));
          },
              icon: Icon(Icons.shopping_cart,color: Colors.white,))
        ],
      ),
      backgroundColor: Colors.deepPurple.shade100,
      drawer: HomeDrawer(),
      body: SafeArea(

        child: Column(

          children: [
            Container(
              child: Text('Our Lastes Products',style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
              ),),
            ),
            SizedBox(height: 15,),
            Consumer<ProductProviders>(
              builder: (
                  context,
                  productProvider ,
                  child) {
                if(productProvider.products.isEmpty){
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: productProvider.products.length,
                    itemBuilder: (ctx, index) {
                      final product = productProvider.products[index];
                      return Card(

                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: ListTile(
                        minTileHeight: 100,
                           tileColor: Colors.yellow.shade100,
                          selectedTileColor: Colors.teal,
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ProductDetailScreen(product: product),));
                          },
                          leading: Image.network(product['image_url'],fit: BoxFit.fill,),
                          title: Text(product['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text("RS.${product['price']}",style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: IconButton(
                            icon: Icon(Icons.add_shopping_cart,size: 25,),
                            onPressed: (){
                              Provider.of<CartProvider>(context,listen: false).addItem(product['id'],product['price'],product['name']);
                            },
                          ),
                        
                        ),
                      );

                  },


                  ),
                );
              },

            ),
          ],
        ),
      ),
    );
  }

}