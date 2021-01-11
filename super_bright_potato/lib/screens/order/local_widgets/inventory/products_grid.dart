import 'package:flutter/cupertino.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'file:///D:/Documents/flutter_projects/super-bright-potato/super_bright_potato/lib/screens/order/local_widgets/inventory/product_card.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key key,
    @required this.products,
    @required GlobalKey<AnimatedListState> listKey,
  })  : _listKey = listKey,
        super(key: key);

  final List<Product> products;
  final GlobalKey<AnimatedListState> _listKey;

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
        return ProductCard(product: product, listKey: _listKey);
      },
    );
  }
}
