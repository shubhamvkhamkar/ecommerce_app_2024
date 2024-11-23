import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import 'check_out_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.cartItems.values.toList();
    final totalAmount = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    /*final paymentService = paymentService();*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 75,
        title: Text('Your Cart',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: cartItems.isEmpty
          ? Center(child: Text('Your Cart is Empty'))
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, index) {
                      final item = cartItems[index];
                      /*final productId = cart.cartItems.keys.toList()[index];*/
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(alignment: Alignment.topRight,
                                  child: TextButton(onPressed: (){
                                     cart.removeItem(item.id);
                                  }, child: Text('Remove product'))
                                  ),
                              Text(
                                'Product ID: ${item.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Name: ${item.name}'),
                              const SizedBox(height: 4),
                              Text('Price: Rs.${item.price.toStringAsFixed(2)}'),
                              const SizedBox(height: 4),
                              Text('Quantity: ${item.quantity}'),
                              const SizedBox(height: 8),
                              Text(
                                'Total: Rs.${(item.price * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: const Border(
                      top: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rs.${totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: cartItems.isEmpty
                            ? null
                            : () {
                          // Checkout logic goes here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
