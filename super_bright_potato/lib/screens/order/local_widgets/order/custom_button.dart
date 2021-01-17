import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return FlatButton(
      onPressed: onTap,
      color: color,
      minWidth: 35,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      child: icon,
    );
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius: BorderRadius.all(Radius.circular(8)),
    //     ),
    //     width: 35,
    //     height: 35,
    //     child: icon,
    //   ),
    // );
  }
}
