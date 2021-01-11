import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';

import 'order_list_product.dart';

class AnimatedOrderList extends StatelessWidget {
  const AnimatedOrderList({
    @required GlobalKey<AnimatedListState> listKey,
  }) : _listKey = listKey;

  final GlobalKey<AnimatedListState> _listKey;
  @override
  Widget build(BuildContext context) {
    return Selector<OrderModel, UnmodifiableListView<Product>>(
      selector: (_, orderModel) => orderModel.products,
      builder: (context, products, __) {
        print("rebuild anim order list");
        return AnimatedList(
          key: _listKey,
          initialItemCount: products.length,
          itemBuilder: (context, i, animation) {
            Product product = products[i];
            return ChangeNotifierProvider.value(
              value: product,
              child: OrderListProduct(
                productIndex: i,
                product: product,
                animation: animation,
                padding: i == (products.length - 1) ? EdgeInsets.zero : null,
              ),
            );
          },
        );
      },
    );
  }
}

// class OrderList extends StatelessWidget {
//   const OrderList({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Selector<OrderModel, UnmodifiableListView<Product>>(
//       selector: (_, orderModel) => orderModel.products,
//       builder: (context, products, __) {
//         print("rebuild order list");
//         return ListView.separated(
//           separatorBuilder: (_, __) => SizedBox(
//             height: 10,
//           ),
//           itemCount: products.length,
//           itemBuilder: (context, i) {
//             Product product = products[i];
//             return ChangeNotifierProvider.value(
//               value: product,
//               child: OrderListProduct(product: product),
//             );
//           },
//         );
//       },
//     );
//   }
// }
