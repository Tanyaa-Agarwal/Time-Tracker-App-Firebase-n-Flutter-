import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/common_widgets/custom_raised_button.dart';
class SocialSignInButton extends CustomRaisedButton{
  SocialSignInButton(
      {
        @required String assetName,
       @required String text,
        Color colour,
        Color textColour,
        VoidCallback onPressed,
      }):assert(assetName!=null),
        assert(text!=null),
        super(child:
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  Image.asset(assetName),
  Text(text,
  style: TextStyle(
    color: textColour,
    fontSize: 15.0,
  ),),
  Opacity(opacity: 0.0,
  child: Image.asset(assetName),),
  ],
  ),
    colour: colour,
    onPressed: onPressed,

  );
}
