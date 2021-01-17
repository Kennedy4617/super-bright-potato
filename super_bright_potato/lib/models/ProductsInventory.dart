import 'dart:collection';

import 'package:super_bright_potato/models/Product.dart';

class ProductsInventory {
  // ToDo: add network service and fetch products from backend
  List<Product> _products = [
    Product(id: 1, name: 'Anvorgesa', price: 10),
    Product(id: 2, name: 'Pan con keso', price: 20),
    Product(id: 3, name: 'Ricopoyo', price: 50),
    Product(id: 4, name: 'Chochomil', price: 15.5),
    Product(id: 5, name: 'Aaaaa', price: 15.5),
    Product(id: 6, name: 'Aaaaaaaaaa', price: 15.5),
    Product(id: 7, name: 'Aaaaaaaaaaaaa', price: 15.5),
  ];
  UnmodifiableListView<Product> get products => UnmodifiableListView(_products);
}
