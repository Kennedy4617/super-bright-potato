import 'package:flutter/cupertino.dart';

List<BoxShadow> kSoftShadow = <BoxShadow>[
  BoxShadow(
    offset: Offset(0, 12),
    blurRadius: 140,
    color: Color.fromRGBO(0, 0, 0, 0.07),
  ),
  BoxShadow(
    offset: Offset(0, 2.7),
    blurRadius: 31.2,
    color: Color.fromRGBO(0, 0, 0, 0.041),
  ),
  BoxShadow(
    offset: Offset(0, 0.8),
    blurRadius: 9.3,
    color: Color.fromRGBO(0, 0, 0, 0.028),
  ),
];

TextStyle kDetailTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(0, 0, 0, 0.6),
);
