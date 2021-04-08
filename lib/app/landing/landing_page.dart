import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/home_page.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';
class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;


  // ignore: deprecated_member_use
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Uuser>(
      stream: auth.onAuthStateChanged,

    builder: (context,snapshot){

      if(snapshot.connectionState==ConnectionState.active)
    {
     Uuser user=snapshot.data;
     if(user==null)
    {
    return SignInPage(
      auth: auth,

      //onSign
     );
    }

    return HomePage(
    auth: auth,
    );
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
