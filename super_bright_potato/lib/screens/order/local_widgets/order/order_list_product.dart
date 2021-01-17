import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_bright_potato/models/OrderModel.dart';
import 'package:super_bright_potato/models/Product.dart';

import 'custom_button.dart';

class OrderListProduct extends StatelessWidget {
  const OrderListProduct({
    Key key,
    @required this.productIndex,
    @required this.product,
    @required this.animation,
    this.padding,
  }) : super(key: key);

  final Product product;
  final int productIndex;
  final Animation<double> animation;
  final EdgeInsets padding;

  Widget _buildRemovedProduct(
      int productIndex, Product product, Animation<double> animation) {
    return StaticOrderListProduct(
      productIndex: productIndex,
      product: product,
      animation: animation,
    );
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> sizeAnimation;
    sizeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: sizeAnimation,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 50,
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
                  Selector<Product, double>(
                    selector: (_, product) => product.price,
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
                  print("rebuilding item");

                  /// Selector of product is used to render the product data
                  /// while read<OrderModel> is used to update values like subtotal
                  /// and total, orderModel will call increase/decreaseAmount and
                  /// remove methods which update those values and also call
                  /// product.increase/decreaseAmount
                  OrderModel orderModel = context.read<OrderModel>();
                  return Row(
                    children: [
                      CustomButton(
                        onTap: amount > 1
                            ? () {
                                orderModel.reduceAmount(product);
                              }
                            : () {
                                orderModel.remove(product);
                                AnimatedList.of(context).removeItem(
                                    productIndex, (context, animation) {
                                  return _buildRemovedProduct(
                                      productIndex, product, animation);
                                });
                              },
                        color:
                            amount > 1 ? Color(0xFFF4F5F6) : Color(0xFFF4213A),
                        icon: amount > 1
                            ? Icon(Icons.remove)
                            : Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: AnimatedAmountText(
                          amount: amount,
                        ),
                      ),
                      CustomButton(
                        onTap: () {
                          orderModel.increaseAmount(product);
                        },
                        color: Color(0xFFF4F5F6),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaticOrderListProduct extends StatelessWidget {
  const StaticOrderListProduct({
    Key key,
    @required this.productIndex,
    @required this.product,
    @required this.animation,
    this.padding,
  }) : super(key: key);

  final int productIndex;
  final Product product;
  final Animation<double> animation;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Animation<double> sizeAnimation;
    sizeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    );
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: sizeAnimation,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 50,
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
                  Text('\$${product.price}'),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  CustomButton(
                    onTap: () => null,
                    color: product.amount > 1
                        ? Color(0xFFC4C4C4)
                        : Color(0xFFF4213A),
                    icon: product.amount > 1
                        ? Icon(Icons.remove)
                        : Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 35,
                    child: ClipRect(
                      child: Center(
                        child: Text(
                          '${product.amount}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () => null,
                    color: Color(0xFFF4F5F6),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedAmountText extends StatelessWidget {
  const AnimatedAmountText({
    @required this.amount,
  });

  final int amount;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        child: Text(
          '$amount',
          textAlign: TextAlign.center,
          key: ValueKey<int>(amount),
        ),
        duration: Duration(milliseconds: 250),
        transitionBuilder: (Widget child, animation) {
          /// transition builder gets called twice so we will abuse that to
          /// separate in/out animation properties
          bool isNewChild = child.key != ValueKey(amount);

          /// get the previous amount to make the proper offset transition
          int previousAmount = context.read<Product>().prevAmount;
          Offset newWidgetOffset = Offset.zero;
          if (amount > previousAmount) {
            /// The amount increased
            /// The offset is bottom to up
            newWidgetOffset = isNewChild ? Offset(0, -2) : Offset(0, 2);
          } else {
            /// The amount decreased
            /// The offset is up to bottom
            newWidgetOffset = isNewChild ? Offset(0, 2) : Offset(0, -2);
          }
          Animation<Offset> offsetAnimation;
          offsetAnimation = Tween<Offset>(
            begin: newWidgetOffset,
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: isNewChild ? Curves.easeIn : Curves.easeOutBack,
              // curve: Curves.easeInOut,
            ),
          );
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
