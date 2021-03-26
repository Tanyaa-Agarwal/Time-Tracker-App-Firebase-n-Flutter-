import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
