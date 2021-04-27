import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/home_page.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:provider/provider.dart';
class LandingPage extends StatelessWidget {



  // ignore: deprecated_member_use
  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<Uuser>(
      stream: auth.onAuthStateChanged,

    builder: (context,snapshot){

      if(snapshot.connectionState==ConnectionState.active)
    {
     Uuser user=snapshot.data;
     if(user==null)
    {
    return SignInPage();
    }

    return HomePage();
}
      else{
       return Scaffold(
         body: Center(
           child: CircularProgressIndicator(),
         ),
       );
      }
    },);

  }
}
