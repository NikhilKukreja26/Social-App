import 'package:flutter/material.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;
  final CrossAxisAlignment crossAxisAlignment;

  const TwoLineItem(
      {Key key, this.firstText, this.secondText, this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text(
          firstText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
