import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;
  void tooglefavorites(Product product) {
  if (_cart.contains(product)) {
    // Increment the quantity of the specific product in the cart
    int index = _cart.indexOf(product);
    _cart[index].quantity++;
  } else {
    // Add product to the cart
    _cart.add(product);
  }
  notifyListeners();
}


  incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  decrementQtn(int index) {
    if (_cart[index].quantity <= 1) {
      return;
    }
    _cart[index].quantity--;
    notifyListeners();
  }

  totalPrice() {
    double total1 = 0;
    for (Product element in _cart) {
      total1 += element.price * element.quantity;
    }
    return total1;
  }
    bool isInCart(Product product) {
      return _cart.contains(product);
    }


  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }

}
