import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    @required this.product,
    @required GlobalKey<AnimatedListState> listKey,
  })  : _listKey = listKey,
        super(key: key);

  final Product product;
  final GlobalKey<AnimatedListState> _listKey;

  @override
  Widget build(BuildContext context) {
    /// Shulada de optimización
    ///
    /// Looks for the product in orderModel
    /// if it exists the button gets disabled.
    /// This only gets called when the orderModel.products list changes via
    /// the add, remove or removeAll methods
    bool isInOrder = context.select<OrderModel, bool>(
      (order) => order.products.contains(product),
    );
    return GestureDetector(
      onTap: isInOrder
          ? null
          : () {
              OrderModel orderModel = context.read<OrderModel>();
              int nextProductIndex = orderModel.products.length;
              orderModel.add(product);
              if (_listKey.currentState != null) {
                _listKey.currentState.insertItem(nextProductIndex);
              }
            },
      child: Container(
        decoration: BoxDecoration(
          color: isInOrder
              ? Color(0xFFC4C4C4).withOpacity(0.4)
              : Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        width: 35,
        height: 35,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
    /*
    return RaisedButton(
      child: Text('Add'),
      onPressed: isInOrder
          ? null
          : () {
              OrderModel orderModel = context.read<OrderModel>();
              orderModel.add(product);
            },
    );*/
  }
}
