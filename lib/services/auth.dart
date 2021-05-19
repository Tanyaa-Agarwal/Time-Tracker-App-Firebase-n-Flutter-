

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Uuser{
  Uuser({@required this.uid,@required this.photoUrl,@required this.displayName});
  final String uid;
  final String photoUrl;
  final String displayName;
}
abstract class AuthBase{
  Future<Uuser> currentUser();
  Future<Uuser> signInAnonymously();
  Stream<Uuser> get onAuthStateChanged;
  Future<Uuser> signInWithGoogle();

  Future<void> signOut();
  Future<Uuser> signInWithEmailAndPassword(String email,String password);
  Future<Uuser> createUserWithEmailAndPassword(String email,String password);
}
class Auth implements AuthBase{
  final _firebaseAuth=FirebaseAuth.instance;
  Uuser _userFromFirebase(User user){
    if(user==null)
      return null;
    return Uuser(
        uid: user.uid,
    photoUrl: user.photoUrl,
    displayName: user.displayName,
    );
  }
  @override
  Stream<Uuser> get onAuthStateChanged{
    // ignore: deprecated_member_use
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }
  @override
  Future<Uuser> currentUser() async {
final user= await _firebaseAuth.currentUser;
return _userFromFirebase(user);
  }
  @override
  Future<Uuser> signInAnonymously() async {
final authResult= await _firebaseAuth.signInAnonymously();
return _userFromFirebase(authResult.user);
  }
  @override
  Future<Uuser> signInWithEmailAndPassword(String email,String password) async{
    final authResult=await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<Uuser> createUserWithEmailAndPassword(String email,String password) async{
    final authResult=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }
  @override
  Future<Uuser> signInWithGoogle()async{
    GoogleSignIn googleSignIn =GoogleSignIn();
    GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    if(googleAccount!=null)
      {
        GoogleSignInAuthentication googleAuth =
        await googleAccount.authentication;
        if(googleAuth.idToken !=null && googleAuth.accessToken!=null)
         {
            final authResult = await _firebaseAuth.signInWithCredential(
                GoogleAuthProvider.getCredential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken,
                )
            );
        return _userFromFirebase(authResult.user);
      }else{
          throw PlatformException(
              code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
              message: 'Missing Google Auth Token',
          );
        }
      }
    else{
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn= GoogleSignIn() ;
   await   googleSignIn.signOut();


  await _firebaseAuth.signOut();
  }
}