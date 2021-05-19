import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInManager{
 SignInManager({@required this.auth,@required this.isLoading});
 final AuthBase auth;
 final ValueNotifier<bool> isLoading;

 Future<Uuser> _signIn(Future<Uuser> Function() signInMethod )async{
  try {
   isLoading.value=true;
   return await signInMethod();
  }catch(e){
   isLoading.value=false;
   rethrow;
  }
 }
 Future<Uuser> signInAnonymously() async => await _signIn(() => auth.signInAnonymously());
 Future<Uuser> signInWithGoogle() async => await _signIn(() => auth.signInWithGoogle());

}