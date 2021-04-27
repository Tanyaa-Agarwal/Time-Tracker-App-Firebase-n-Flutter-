import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_form.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:provider/provider.dart';
class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthBase>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(child: EmailSignInForm()),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
