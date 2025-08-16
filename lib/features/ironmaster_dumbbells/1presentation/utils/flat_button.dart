import 'package:flutter/material.dart';

flatButton(String text, double height, double width, Function? callback) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    minimumSize: Size(width, height),
    backgroundColor: Colors.grey,
    padding: EdgeInsets.all(0),
  );
  return TextButton(
    style: flatButtonStyle,
    onPressed: (callback != null) ? callback() : () {},
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}
