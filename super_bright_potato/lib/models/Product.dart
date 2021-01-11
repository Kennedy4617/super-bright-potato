import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  Product({
    this.id,
    this.image,
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
  // The product's unique id
  final int id;

  /// The product's image url, used by NetworkImage wrapped in an image widget
  /// or by Image.network widget constructor on it's behalf
  final String image;

  /// The product's name
  final String name;

  /// The product's unit price
  final double price;

  /// The product's amount
  int amount;

  /// used exclusively for animations
  int _prevAmount = 0;

  /// returns the previous value of [amount]
  int get prevAmount => _prevAmount;

  /// Increase the product amount
  void increaseAmount() {
    // ToDo: check for stock(?
    _prevAmount = amount++;
    // Rebuild this single item widget in the list
    notifyListeners();
  }

  /// Reduce the product amount
  void reduceAmount() {
    _prevAmount = amount--;
    // Rebuild this single item widget in the list
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    return (other is Product) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
