import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/landing/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return Provider<AuthBase>(
     create: (context) => Auth() ,
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home:LandingPage(

        ),
      ),
    );
  }
}

