
import 'package:time_tracker_app/app/sign_in/validators.dart';

enum EmailSignInFormType {signIn,register}
class EmailSignInModel with EmailAndPasswordValidators{
  EmailSignInModel(
  {
    this.email='',
    this.password='',
    this.formType=EmailSignInFormType.signIn,
    this.isLoading=false,
    this.submitted=false,
}
      );
  final String email;
  final String password;
  final bool isLoading;
  final bool submitted;
  final EmailSignInFormType formType;
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
  EmailSignInModel copyWith({
   String email,
 String password,
 bool isLoading,
 bool submitted,
 EmailSignInFormType formType,
}){
return EmailSignInModel(
  email: email?? this.email,
  password: password?? this.password,
  isLoading: isLoading?? this.isLoading,
  submitted: submitted?? this.submitted,
  formType: formType?? this.formType,
);
}

}