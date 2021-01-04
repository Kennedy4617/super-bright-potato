import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'test_data/products.dart';

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
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => OrderModel()),
            ChangeNotifierProvider(create: (_) => Product()),
          ],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Productos'),
                    Expanded(
                      // ToDo: Move to it's own widget
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, idx) {
                          // ToDo: create custom product card widget
                          return Container(
                            child: Column(
                              children: [
                                Text(products[idx].name),
                                RaisedButton(
                                  onPressed: () {
                                    // ToDo: somehow disable button when the product is in orderModel and enable again when it's removed
                                    OrderModel orderModel =
                                        context.read<OrderModel>();
                                    orderModel.add(products[idx]);
                                  },
                                ),
                              ],
                            ),
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
                  child: Column(
                    children: [
                      Text('Right side'),
                      Expanded(
                        // ToDo: Move to it's own widget
                        child: Consumer<OrderModel>(
                          builder: (_, orderModel, __) => ListView.builder(
                            itemCount: orderModel.products.length,
                            itemBuilder: (context, i) {
                              return Consumer<Product>(
                                builder: (_, product, __) {
                                  return Row(
                                    // ToDo: use Selector<Product, <prop>>
                                    //  instead of Consumer to update only
                                    //  needed values (optimization baby)
                                    children: [
                                      Text(orderModel.products[i].name),
                                      Spacer(),
                                      Text(
                                        orderModel.products[i].amount
                                            .toString(),
                                      ),
                                      Spacer(),
                                      Text(
                                        '\$${orderModel.products[i].price.toString()}',
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
