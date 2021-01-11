import 'package:flutter/cupertino.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'file:///D:/Documents/flutter_projects/super-bright-potato/super_bright_potato/lib/screens/order/local_widgets/inventory/products_grid.dart';

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
        Text('Productos'),
        Expanded(
          // ToDo: Move to it's own widget
          child: ProductsGrid(products: products, listKey: _listKey),
        ),
      ],
    );
  }
}
