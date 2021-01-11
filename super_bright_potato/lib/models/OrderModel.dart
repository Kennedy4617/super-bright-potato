import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:super_bright_potato/models/Product.dart';

class OrderModel extends ChangeNotifier {
  // Private state of the order list
  final List<Product> _products = <Product>[];

  /// Current price of items in the order
  double _subTotal = 0;

  /// Get subtotal
  double get subTotal => _subTotal;
  // ToDo: implement proper total price
  double get total => _subTotal;
  // ToDo: implement taxes as List<double> or just double

  // A read-only list of products in the order.
  UnmodifiableListView<Product> get products =>
      UnmodifiableListView([..._products]);

  /// Adds a product from the order list
  /// this can only happen once, then the add button must be disabled
  void add(Product product) {
    _products.add(product);
    updateSubtotal();
    // Rebuild order list
    notifyListeners();
  }

  /// Increase the product amount without rebuilding the whole list
  /// The product model handles it's own state
  void increaseAmount(Product product) {
    product.increaseAmount();
    updateSubtotal();
    notifyListeners();
  }

  /// Reduce the product amount without rebuilding the whole list
  /// The product model handles it's own state
  void reduceAmount(Product product) {
    product.reduceAmount();
    updateSubtotal();
    notifyListeners();
  }

  /// Removes a product from order the list and returns the removed item.
  /// This method is only called when a product has only 1 item
  /// and the user presses the reduce button again
  Product remove(Product product) {
    int productIndex = _products.indexOf(product);
    Product removedProduct = _products.removeAt(productIndex);
    // _products.remove(product);
    updateSubtotal();
    // Rebuild order list
    notifyListeners();
    return removedProduct;
  }

  /// Removes all items
  void removeAll() {
    _products.clear();
    updateSubtotal();
    // Rebuild order list
    notifyListeners();
  }

  /// Finds and returns a product within the _products list
  /// returns null if the product is not in the list
  Product findById(int id) {
    Product match = _products.firstWhere(
      (prod) => prod.id == id,
      orElse: () => null,
    );
    return match;
  }

  void updateSubtotal() {
    _subTotal = _products.fold(
        0, (total, current) => total + (current.price * current.amount));
    print('\$$_subTotal');
  }

  // ToDo: implement discounts and total getter
}
