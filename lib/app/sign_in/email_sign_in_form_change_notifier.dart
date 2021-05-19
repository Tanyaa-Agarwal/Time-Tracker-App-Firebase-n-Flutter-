import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_change_model.dart';
import 'package:time_tracker_app/common_widgets/form_submit_button.dart';
import 'package:time_tracker_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'email_sign_in_model.dart';


class EmailSignInFormChangeNotifier extends StatefulWidget{
  EmailSignInFormChangeNotifier({@required this.model});
  final EmailSignInChangeModel model;
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }
  @override
  _EmailSignInFormChangeNotifierState createState() => _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final FocusNode _emailFocusNode =FocusNode();
  final FocusNode _passwordFocusNode=FocusNode();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async{
    try {
     await widget.model.submit();
      Navigator.of(context).pop();
    }on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,

      ).show(context);
    }

  }
  void _emailEditingComplete(){
    final newFocus=widget.model.emailValidator.isValid(widget.model.email)?_passwordFocusNode:_emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleForemType(){
    widget.model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(){

    return [
      _buildEmailTextField(),
      SizedBox(height:8.0),
      _buildPasswordTextField(),
      SizedBox(height:8.0),
      FormSubmitButton(
        text: widget.model.primaryButtonText,
        onPressed: widget.model.canSubmit?_submit: null,
      ),
      SizedBox(height:8.0),
      FlatButton(
        child: Text(widget.model.secondaryButtonText),
        onPressed: !widget.model.isLoading?()=>_toggleForemType():null,
      )


    ];
  }

  TextField _buildPasswordTextField() {

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: widget.model.passwordErrorText,
        enabled: widget.model.isLoading==false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => widget.model.updatePassword(password),

    );
  }

  TextField _buildEmailTextField() {

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: widget.model.emailErrorText,
        enabled: widget.model.isLoading==false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete:()=> _emailEditingComplete(),
      onChanged: (email) => widget.model.updateEmail(email),
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

}
