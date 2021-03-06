import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_app/app/sign_in/SignInManager.dart';
import 'package:time_tracker_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_button.dart';

import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key key,@required this.manager,@required this.isLoading}):super(key: key);
  final SignInManager manager;
  final bool isLoading;
  static Widget create(BuildContext context){
    final auth=Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_,ValueNotifier<bool>isLoading,__) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth,isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context,manager,_)=>SignInPage(manager: manager,
            isLoading: isLoading.value,),),
        ),
      ),
    );
  }
void _showSignInError(BuildContext context,PlatformException exception ){
  PlatformExceptionAlertDialog(title: 'Sign in failed', exception: exception).show(context);
}

  Future<void> _signInAnonymously(BuildContext context) async{
    try {
     await manager.signInAnonymously();
    }on PlatformException catch(e){
      if(e.code!='ERROR_ABORTED_BY_USER')
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {

      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if(e.code!='ERROR_ABORTED_BY_USER')
      _showSignInError(context, e);
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
      body:  _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.0,
              child: _buildHeader()),

          SizedBox(
            height: 48.0,
          ),
        SocialSignInButton(
          assetName: 'images/google-logo.png',
           text:'Sign in with Google' ,
           colour: Colors.white,
           textColour: Colors.black87,
           onPressed:isLoading?null:()=> _signInWithGoogle(context),
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
            onPressed:isLoading?null: () => _signInWithEmail(context),
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
            onPressed:isLoading?null:() =>_signInAnonymously(context),
          ),
    ],
      ),
    );
  }
  Widget _buildHeader(){
  if(isLoading){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Text(
    'Sign In',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
    ),
  );
  }
}
