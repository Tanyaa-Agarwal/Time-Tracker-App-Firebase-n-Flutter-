import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_button.dart';

import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/auth.dart';


class SignInPage extends StatelessWidget {

  Future<void> _signInAnonymously(BuildContext context) async{
    try {
      final auth=Provider.of<AuthBase>(context,listen: false);
     await auth.signInAnonymously();

    }catch(e){
      print(e.toString());
    }
  }
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth=Provider.of<AuthBase>(context,listen: false);
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context){
   Navigator.of(context).push(
     MaterialPageRoute<void>(
       fullscreenDialog: true,
         builder: (context) => EmailSignInPage(),
    ),
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Time Tracker',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
        SocialSignInButton(
          assetName: 'images/google-logo.png',
           text:'Sign in with Google' ,
           colour: Colors.white,
           textColour: Colors.black87,
           onPressed:()=> _signInWithGoogle(context),
         ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColour: Colors.white,
            colour: Color(0xff334D92),
            onPressed:(){},
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColour: Colors.white,
            colour: Colors.teal[700],
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColour: Colors.black87,
            colour: Colors.lime[300],
            onPressed:() =>_signInAnonymously(context),
          ),
    ],
      ),
    );
  }
}
