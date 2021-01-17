import 'package:flutter/cupertino.dart';

List<BoxShadow> kSoftShadow = <BoxShadow>[
  BoxShadow(
    offset: Offset(0, 11),
    blurRadius: 100,
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

TextStyle kDetailHighlightTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: 20,
  color: Color(0xFF000000),
);

TextStyle kActiveTabTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20,
  // ToDo: change color based on active tab
  color: Color(0xFF000000),
);

TextStyle kDefaultTabTextStyle =
    kActiveTabTextStyle.copyWith(color: Color(0xFF828282));
