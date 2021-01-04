import 'package:flutter/material.dart';
import 'package:super_bright_potato/models/OrderModel.dart';

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
      ),
      home: MyHomePage(title: 'La wea rara'),
    );
  }
}

OrderModel orderModel = new OrderModel();

class MyHomePage extends StatelessWidget {
  const MyHomePage({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Productos'),
                  Expanded(
                    child: GridView.builder(
                      itemCount: orderModel.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, idx) {
                        return Container(
                          child: Text(orderModel.products[idx].name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Container(
                color: Colors.blueAccent,
                child: Text('Right side'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
