import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
class HomePage extends StatelessWidget {
  HomePage({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async{
    try {
    await auth.signOut();

    }catch(e){
      print(e.toString());
    }

  }
  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut=await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to Logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if(didRequestSignOut==true)
      {
        _signOut();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            onPressed: () =>_confirmSignOut(context),
            child: Text('Logout',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),),),
        ],
      ),
    );
  }
}
