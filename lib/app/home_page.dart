import 'dart:async';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
class HomePage extends StatelessWidget {


  Future<void> _signOut(BuildContext context) async{
    try {
      final auth=Provider.of<AuthBase>(context,listen: false);
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
        _signOut(context);
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
