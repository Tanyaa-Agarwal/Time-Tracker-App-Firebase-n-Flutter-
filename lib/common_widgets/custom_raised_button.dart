import 'package:flutter/material.dart';
class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({this.child,
    this.colour,
    this.borderRadius:2.0,
    this.onPressed,
    this.height:50.0})
      :assert(borderRadius!=null);
 final Widget child;
 final Color colour;
 final double borderRadius;
 final VoidCallback onPressed;
 final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(onPressed:onPressed,
        child: child,
        color: colour,
        disabledColor: colour,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
        ),
      ),
    );

  }
}
