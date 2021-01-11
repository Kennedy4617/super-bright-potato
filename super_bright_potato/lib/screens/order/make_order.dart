import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'package:super_bright_potato/models/ProductsInventory.dart';

import 'local_widgets/inventory/products_panel.dart';
import 'local_widgets/order/order_panel.dart';

class OrderScreen extends StatelessWidget {
  /// ToDo: set the [_listKey] as an OrderModel property to prevent the need to deeply pass the variable over and over
  /// The animated list key is stored up in the tree because it needs to be
  /// accessed from the ProductsGrid and OrderPanel
  final GlobalKey _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    ProductsInventory inventory = new ProductsInventory();
    List<Product> products = inventory.products;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ChangeNotifierProvider(
            create: (_) => OrderModel(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ProductsPanel(products: products, listKey: _listKey),
                ),
                SizedBox(
                  width: 380,
                  child: OrderPanel(listKey: _listKey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
