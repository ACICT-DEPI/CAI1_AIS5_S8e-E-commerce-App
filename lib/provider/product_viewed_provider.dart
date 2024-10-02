import 'package:e_commerce/models/products.dart';
import 'package:flutter/material.dart';

class ViewedProductsProvider with ChangeNotifier {
  final List<Product> _viewedProducts = [];

  List<Product> get viewedProducts => _viewedProducts;

  void addProduct(Product product) {
    // Check if product is already in the viewed list
    if (!_viewedProducts.contains(product)) {
      _viewedProducts.add(product);
      print('Product added: ${product.title}'); // Add this print statement to debug
      notifyListeners();
    }
  }
}

