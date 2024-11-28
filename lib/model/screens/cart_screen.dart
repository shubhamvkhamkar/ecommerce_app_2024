import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';

class CartScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    final cart =  Provider.of<CartProvider>(context);
    /*final paymentService = paymentService();*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cart.cartItems.isEmpty 
      ? Center(child: Text('Your Cart is Empty'))
      : Column(
        children: [
          ListView.builder(
            itemCount: cart.cartItems.length,
              itemBuilder: (ctx, index) {
             final productId = cart.cartItems.keys.toList()[index];
             return ListTile(
               title: Text('Produxt $productId'),
               trailing: Text('Qty: ${cart.cartItems[productId]}'),
             );
          }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(onPressed: (){
              /*paymentService.openCheckout(cart.totalPrice);*/
            }, child: Text('CheckOut ${cart.totalPrice}')),
          )
        ],
      ),
    );

  }

}