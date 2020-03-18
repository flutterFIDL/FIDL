import 'package:flutter/material.dart';

class ShapeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  ShapeButton({@required this.onPressed, @required this.child});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.amber,
        highlightColor: Colors.amber[700],
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        child: this.child,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onPressed: this.onPressed);
  }
}
