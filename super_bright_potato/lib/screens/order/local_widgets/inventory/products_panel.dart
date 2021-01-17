import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_bright_potato/constants.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'products_grid.dart';

class ProductsPanel extends StatelessWidget {
  const ProductsPanel({
    Key key,
    @required this.products,
    @required GlobalKey<AnimatedListState> listKey,
  })  : _listKey = listKey,
        super(key: key);

  final List<Product> products;
  final GlobalKey<AnimatedListState> _listKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          child: Row(
            children: [
              Icon(Icons.chevron_left),
              SizedBox(width: 20),
              Text(
                'Productos',
                style: kActiveTabTextStyle,
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                'Categorías',
                style: kDefaultTabTextStyle,
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                'Descuetos',
                style: kDefaultTabTextStyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: ProductsGrid(products: products, listKey: _listKey),
        ),
      ],
    );
  }
}
