import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_bright_potato/models/Product.dart';
import 'package:super_bright_potato/constants.dart';

import 'add_product_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    @required GlobalKey<AnimatedListState> listKey,
  })  : _listKey = listKey,
        super(key: key);

  final Product product;
  final GlobalKey<AnimatedListState> _listKey;

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
                    '\$${product.price}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF2C3E50).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              AddButton(
                product: product,
                listKey: _listKey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
