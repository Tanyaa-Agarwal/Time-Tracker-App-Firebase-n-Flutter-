import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/validators.dart';
import 'package:time_tracker_app/common_widgets/form_submit_button.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType {signIn,register}
class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators{

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final FocusNode _emailFocusNode =FocusNode();
  final FocusNode _passwordFocusNode=FocusNode();
 String get _email =>_emailController.text;
 String get _password =>_passwordController.text;
  EmailSignInFormType _formType =EmailSignInFormType.signIn;
  bool _submitted=false;
  bool _isLoading=false;
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async{
    setState(() {
      _submitted=true;
      _isLoading=true;
    });
    try {
      final auth=Provider.of<AuthBase>(context,listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      }
      else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    }on PlatformException catch(e){
   PlatformExceptionAlertDialog(
     title: 'Sign in failed',
     exception: e,

   ).show(context);

    }finally{
      setState(() {
        _isLoading=false;
      });
    }

  }
  void _emailEditingComplete(){
    final newFocus=widget.emailValidator.isValid(_email)?_passwordFocusNode:_emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleForemType(){
    setState(() {
      _submitted=false;
      _formType=_formType==EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    final primaryText=_formType==EmailSignInFormType.signIn
        ? 'Sign in'
        :'Create an account';
    final secondaryText=_formType==EmailSignInFormType.signIn
        ?'Need an account? Register'
        :'Have an account? Sign in';
    bool submitEnabled= widget.emailValidator.isValid(_email)
        && widget.emailValidator.isValid(_password) && !_isLoading;
    return [
      _buildEmailTextField(),
      SizedBox(height:8.0),
      _buildPasswordTextField(),
      SizedBox(height:8.0),
      FormSubmitButton(
        text: primaryText,
          onPressed: submitEnabled?_submit: null,
          ),
      SizedBox(height:8.0),
      FlatButton(
    child: Text(secondaryText),
          onPressed: !_isLoading?_toggleForemType:null,
          )


    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText= _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText? widget.invalidPasswordErrorText:null,
        enabled: _isLoading==false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
     onEditingComplete: _submit,
      onChanged: (password) => _updateState(),

    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText=_submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ?widget.invalidEmailErrorText:null,
        enabled: _isLoading==false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
  _updateState(){
    print('email: $_email, password; $_password');
    setState(() {
    });
  }
}
