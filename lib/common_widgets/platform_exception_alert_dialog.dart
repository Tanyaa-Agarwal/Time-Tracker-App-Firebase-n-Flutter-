import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog{
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception}) : super(
    title: title,
    content: _message(exception),
    defaultActionText: 'OK'
  );
  static String _message(PlatformException exception){
    return _errors[exception.code]??exception.message;
  }
  static Map<String,String> _errors ={

  };
}