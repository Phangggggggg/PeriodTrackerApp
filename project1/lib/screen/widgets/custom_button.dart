import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  var onTap;
  var activeColor;
  var inactiveColor;
  var active;
  var width;
  var height;
  var widget;
  String text;
  MyButton(
      {Key key,
      this.onTap,
      this.activeColor,
      this.inactiveColor,
      this.active,
      this.widget,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          child: Center(child: widget),
          margin: EdgeInsets.all(5.0),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: active ? activeColor : inactiveColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(34.0),
            ),
          ),
        ));
  }
}
