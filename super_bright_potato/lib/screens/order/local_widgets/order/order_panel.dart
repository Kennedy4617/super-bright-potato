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
      decoration: BoxDecoration(
        color: Color(0xFFFFDFDFB),
        border: Border(
          left: BorderSide(
            color: Color(0xFFDFE9F0),
          ),
        ),
      ),
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
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                onPressed: () {
                  // OrderModel orderModel = context.read<OrderModel>();
                  // orderModel.removeAll();
                },
                child: Text('Quitar todo'),
              ),
            ],
          ),
          Expanded(
            // child: OrderList(listKey: _listKey),
            child: AnimatedOrderList(listKey: _listKey),
          ),
          SizedBox(height: 20),
          OrderDetailsCard(),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  height: 44,
                  onPressed: () {},
                  color: Color(0xFF40CD28),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: FlatButton(
                  height: 44,
                  onPressed: () {
                    // Navigate to checkout page
                  },
                  color: Color(0xFF40CD28),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Pagar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: kSoftShadow,
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
    );
  }
}
