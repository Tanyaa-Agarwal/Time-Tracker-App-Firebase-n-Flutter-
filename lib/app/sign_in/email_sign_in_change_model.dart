
import 'package:flutter/foundation.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_app/app/sign_in/validators.dart';
import 'package:time_tracker_app/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier{
  EmailSignInChangeModel(
      {
        this.email='',
        this.password='',
        this.formType=EmailSignInFormType.signIn,
        this.isLoading=false,
        this.submitted=false,
        @required this.auth,
      }
      );
  final AuthBase auth;
   String email;
  String password;
  bool isLoading;
 bool submitted;
 EmailSignInFormType formType;
  Future<void> submit() async{
    updateWith(submitted: true,isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      }
      else {
        await auth.createUserWithEmailAndPassword(email,password);
      }
    }catch(e){
      updateWith(isLoading: false);
      rethrow;
    }

  }
  String get emailErrorText{
    bool showErrorText=submitted && !emailValidator.isValid(email);
    return showErrorText?invalidEmailErrorText:null;
  }
  String get passwordErrorText{
    bool showErrorText= submitted && !passwordValidator.isValid(password);
    return showErrorText?invalidPasswordErrorText:null;
  }
  String get primaryButtonText{
    return formType==EmailSignInFormType.signIn
        ? 'Sign in'
        :'Create an account';
  }
  String get secondaryButtonText{
    return formType==EmailSignInFormType.signIn
        ?'Need an account? Register'
        :'Have an account? Sign in';
  }
  bool get canSubmit{
    return emailValidator.isValid(email)
        && emailValidator.isValid(password) && !isLoading;
  }
  void toggleFormType(){
    updateWith(email: '',
      password: '',
      isLoading: false,
      submitted: false,
      formType: this.formType==EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn,);
  }
  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
 void updateWith({
    String email,
    String password,
    bool isLoading,
    bool submitted,
    EmailSignInFormType formType,
  }){

      this.email= email?? this.email;
      this.password=password?? this.password;
      this.isLoading= isLoading?? this.isLoading;
     this.submitted=submitted?? this.submitted;
      this.formType=formType?? this.formType;
      notifyListeners();
  }

}