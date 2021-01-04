import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:super_bright_potato/models/Product.dart';

class OrderModel extends ChangeNotifier {
  // Private state of the order list
  // final List<Product> _products = <Product>[];
  final List<Product> _products = [
    Product(id: 1, name: 'Anvorgesa', price: 10),
    Product(id: 2, name: 'Pan con keso', price: 20),
    Product(id: 3, name: 'Ricopoyo', price: 50),
    Product(id: 4, name: 'Chochomil', price: 15.5),
  ];

  // A read-only list of products in the order.
  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);

  /// Adds a product from the order list
  /// this can only happen once, then the add button must be disabled
  void add(Product product) {
    _products.add(product);
    // Rebuild order list
    notifyListeners();
  }

  /// Increase the product amount without rebuilding the whole list
  /// The product model handles it's own state
  void increaseAmount(Product product) {
    product.increaseAmount();
  }

  /// Reduce the product amount without rebuilding the whole list
  /// The product model handles it's own state
  void reduceAmount(Product product) {
    if (product.amount > 1) {
      product.reduceAmount();
    } else {
      // If the product is 1 or less than one then the product must be removed
      this.remove(product);
    }
  }

  /// Removes a product from order the list this method is only called when
  /// a product has only 1 item and the user presses the reduce button again
  void remove(Product product) {
    _products.remove(product);
    // Rebuild order list
    notifyListeners();
  }

  /// Removes all items
  void removeAll() {
    _products.clear();
    // Rebuild order list
    notifyListeners();
  }
}

/// Test values
List<Product> products = [
  Product(id: 1, name: 'Anvorgesa', price: 10),
  Product(id: 2, name: 'Pan con keso', price: 20),
  Product(id: 3, name: 'Ricopoyo', price: 50),
  Product(id: 4, name: 'Chochomil', price: 15.5),
];
