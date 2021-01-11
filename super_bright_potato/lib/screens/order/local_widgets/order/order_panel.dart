import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/constants.dart';

import 'order_list.dart';

class OrderPanel extends StatelessWidget {
  const OrderPanel({
    @required GlobalKey<AnimatedListState> listKey,
    Key key,
  })  : _listKey = listKey,
        super(key: key);

  final GlobalKey<AnimatedListState> _listKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: Color(0xFFF1F1F1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orden',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              FlatButton(
                color: Color(0xFFF5D4D4),
                textColor: Color(0xFFF4213A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                onPressed: () {
                  print("heh");
                },
                child: Text('Quitar todo'),
              ),
            ],
          ),
          Expanded(
            // child: OrderList(listKey: _listKey),
            child: AnimatedOrderList(listKey: _listKey),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: kDetailTextStyle,
                    ),
                    Selector<OrderModel, double>(
                      selector: (_, orderModel) => orderModel.subTotal,
                      builder: (_, subTotal, __) => Text(
                        '\$$subTotal',
                        style: kDetailTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Descuentos',
                      style: kDetailTextStyle,
                    ),
                    Selector<OrderModel, double>(
                      selector: (_, orderModel) => orderModel.subTotal,
                      builder: (_, subTotal, __) => Text(
                        '\$0',
                        style: kDetailTextStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: kDetailHighlightTextStyle,
                    ),

                    /// ToDo: wrap order details in the same selector since they depend on each other
                    Selector<OrderModel, double>(
                      selector: (_, orderModel) => orderModel.total,
                      builder: (_, total, __) => Text(
                        '\$$total',
                        style: kDetailHighlightTextStyle,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
