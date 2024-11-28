import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, int> _cartItems = {};

  Map<String, int> get cartItems => _cartItems;

  void addItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId] = _cartItems[productId]! + 1;
    } else {
      _cartItems[productId] = 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  int get itemCount => _cartItems.length;

  int get totalPrice => _cartItems.entries
      .map((entry) => entry.value * 100) // Replace 100 with product price lookup
      .reduce((value, element) => value + element);
}


/*
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, int> _cartItems = {}; // Product ID -> Quantity

  Map<String, int> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  void addItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId] = _cartItems[productId]! + 1;
    } else {
      _cartItems[productId] = 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems[productId] = _cartItems[productId]! - 1;
      if (_cartItems[productId]! <= 0) {
        _cartItems.remove(productId);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double getTotalPrice(Map<String, dynamic> productData) {
    double total = 0.0;
    _cartItems.forEach((productId, quantity) {
      total += productData[productId]['price'] * quantity;
    });
    return total;
  }
}
*/
