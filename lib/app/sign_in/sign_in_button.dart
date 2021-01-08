import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/common_widgets/custom_raised_button.dart';
class SignInButton extends CustomRaisedButton{
  SignInButton(
      {

        @required String text,
        Color colour,
        Color textColour,
        VoidCallback onPressed,
      }):assert(text!=null),
        super(child:
      Text(text,
        style: TextStyle(
          color: textColour,
          fontSize: 15.0,
        ),
  ),
    colour: colour,
    onPressed: onPressed,

  );
}
