import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/screens/order/make_order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: OrderScreen(),
    );
  }
}

// OrderModel orderModel = new OrderModel();
