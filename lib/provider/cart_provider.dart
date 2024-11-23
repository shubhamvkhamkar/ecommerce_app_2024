/*
import 'package:flutter/material.dart';


class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

final Map<String, double> _productPrices = {
  'product1': 29.99,
  'product2': 49.99,
  'product3': 19.99,
};

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  void addItem(String id, String name, double price) {
    if (_cartItems.containsKey(id)) {
      // Update quantity if item already in cart
      _productPrices[id] = price;
      _cartItems.update(
        id,
            (existingItem) =>
            CartItem(
              id: existingItem.id,
              name: existingItem.name,
              price: existingItem.price,
              quantity: existingItem.quantity + 1,
            ),
      );
    } else {
      // Add new item
      _cartItems.putIfAbsent(
        id,
            () => CartItem(id: id, name: name, price: price, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }




  int get itemCount => _cartItems.length;

  double get totalPrice =>
      _cartItems.entries
          .map((entry) => entry.value * (_productPrices[entry.key] ??
          0.0)) // Replace 100 with product price lookup
          .fold(0.0, (sum, element) => sum + element);
}

*/


import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}


class CartProvider with ChangeNotifier {

final Map<String, double> _productPrices = {
    'product1': 29.99,
    'product2': 49.99,
    'product3': 19.99,
  };

  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => _cartItems;

  void addItem(String id, double price,String name) {

    if (_cartItems.containsKey(id)) {
      _productPrices[id] = price;
      _cartItems.update(
        id,
            (existingItem) =>
            CartItem(
              id: existingItem.id,
              name: existingItem.name,
              price: existingItem.price,
              quantity: existingItem.quantity + 1,
            ),
      );
    } else {
      _cartItems.putIfAbsent(
        id,
            () => CartItem(id: id, name: name, price: price, quantity: 1),
      );

    }
    notifyListeners();
  }

  void removeItem(String id) {
    if(_cartItems.containsKey(id)) {
      _cartItems.remove(id);
      notifyListeners();
    }
  }

  int get itemCount => _cartItems.length;

   void clearCart() {
  _cartItems.clear();
  notifyListeners();
}

  /*double get totalPrice =>
      _cartItems.entries
          .map((entry) => entry.value * (_productPrices[entry.key] ??
          0.0)) // Replace 100 with product price lookup
          .fold(0.0, (sum, element) => sum + element);*/


}
