import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/home/home_page.dart';
import 'package:time_tracker_app/app/home/jobs/jobs_page.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/database.dart';
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
    return SignInPage.create(context);
    }
     //provider of database as parent of jobs page
    return Provider<Uuser>.value(
      value: user,
      child: Provider<Database>(
        create: (_)=>FirestoreDatabase(uid: user.uid),
          child: HomePage()),
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
