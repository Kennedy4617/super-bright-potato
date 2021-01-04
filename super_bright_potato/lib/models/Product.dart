import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.price,
    // Default to one but leave option in the constructor
    // in case there's anything in the future
    // that automatically adds more than one product
    this.amount = 1,
  })  : assert(id != null),
        assert(name != null),
        assert(price >= 0),
        assert(amount > 0);
  final int id;
  final String name;
  final double price;
  int amount;

  /// Increase the product amount
  void increaseAmount() {
    // ToDo: check for stock(?
    this.amount++;
    // Rebuild this single item widget in the list
    notifyListeners();
  }

  /// Reduce the product amount
  void reduceAmount() {
    this.amount--;
    // Rebuild this single item widget in the list
    notifyListeners();
  }
}
