import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously()async{
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      print('${authResult.user.uid}');
    }catch(e){
      print(e.toString());
    }

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
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
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
           onPressed: (){},
         ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColour: Colors.white,
            colour: Color(0xff334D92),
            onPressed: (){},
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColour: Colors.white,
            colour: Colors.teal[700],
            onPressed: (){},
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
            onPressed: _signInAnonymously,
          ),
    ],
      ),
    );
  }
}
