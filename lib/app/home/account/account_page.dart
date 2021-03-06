import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/avatar.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
class AccountPage extends StatelessWidget {

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
      final user=Provider.of<Uuser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          FlatButton(
            onPressed: () =>_confirmSignOut(context),
            child: Text('Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),),),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: _buildUserInfo(user),
        ),
      ),

    );
  }

 Widget _buildUserInfo(Uuser user) {
      return Column(
        children: [
          Avatar(
            radius: 50.0,
          photoUrl: user.photoUrl,),
          SizedBox(
            height: 8,
          ),
          if(user.displayName!=null)
            Text(
              user.displayName,
              style: TextStyle(color: Colors.white),
            ),
          SizedBox(
            height: 8,
          ),
        ],
      );
  }
}
