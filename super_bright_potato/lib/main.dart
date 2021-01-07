import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/constants.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'package:super_bright_potato/models/ProductsInventory.dart';
// import 'test_data/products.dart';

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
      home: MyHomePage(),
    );
  }
}

OrderModel orderModel = new OrderModel();

class MyHomePage extends StatelessWidget {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Productos'),
                      Expanded(
                        // ToDo: Move to it's own widget
                        child: ProductsGrid(products: products),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 380,
                  child: Container(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              onPressed: () {
                                print("heh");
                              },
                              child: Text('Quitar todo'),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Consumer<OrderModel>(
                            builder: (_, orderModel, __) => ListView.builder(
                              itemCount: orderModel.products.length,
                              itemBuilder: (context, i) {
                                Product product = orderModel.products[i];
                                return ChangeNotifierProvider.value(
                                  value: product,
                                  child: OrderListProduct(product: product),
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
      ),
    );
  }
}

class OrderListProduct extends StatelessWidget {
  const OrderListProduct({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    /// Intrinsic height is a gift from the gods at google team
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: FadeInImage(
              height: 50,
              width: 50,
              placeholder: AssetImage('assets/images/anvorguesa.jpg'),
              image: product.image == null
                  ? AssetImage('assets/images/anvorguesa.jpg')
                  : NetworkImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.name),
              Selector<Product, String>(
                selector: (_, product) => product.price.toString(),
                builder: (_, price, __) {
                  return Text('\$$price');
                },
              ),
            ],
          ),
          Spacer(),
          Selector<Product, int>(
            selector: (_, product) => product.amount,
            builder: (_, amount, __) {
              return Row(
                children: [
                  CustomButton(
                    onTap: amount > 1
                        ? () {
                            product.reduceAmount();
                          }
                        : () {
                            OrderModel orderModel = context.read<OrderModel>();
                            orderModel.remove(product);
                          },
                    color: amount > 1 ? Color(0xFFC4C4C4) : Color(0xFFF4213A),
                    icon: amount > 1
                        ? Icon(Icons.remove)
                        : Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(
                      width: 35,
                      child: Text(
                        amount.toString(),
                        textAlign: TextAlign.center,
                      )),
                  CustomButton(
                    onTap: () {
                      product.increaseAmount();
                    },
                    color: Color(0xFFC4C4C4),
                    icon: Icon(Icons.add),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.onTap,
    @required this.color,
    @required this.icon,
    Key key,
  }) : super(key: key);

  final Function onTap;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        width: 35,
        height: 35,
        child: icon,
      ),
    );
  }
}

// ToDo: Implement design
class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(30.0),
      itemCount: products.length,
      clipBehavior: Clip.none,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 35,
        crossAxisSpacing: 35,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.2,
      ),
      itemBuilder: (context, idx) {
        Product product = products[idx];
        return ProductCard(product: product);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  /// ToDo: Remove the add button and add a gesture detector as a stack overlay
  /// to prevent re-building the whole card only to disable the onTap callback
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: kSoftShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //AspectRatio(
          //aspectRatio: 1 / 1,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: FadeInImage(
                placeholder: AssetImage('assets/images/anvorguesa.jpg'),
                image: product.image == null
                    ? AssetImage('assets/images/anvorguesa.jpg')
                    : NetworkImage(product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  Text(
                    '\$${product.price.toString()}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF2C3E50).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              AddButton(product: product),
            ],
          ),
        ],
      ),
    );
  }
}

// ToDo: Implement design
class AddButton extends StatelessWidget {
  const AddButton({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

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
              orderModel.add(product);
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
