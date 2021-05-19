import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/database.dart';
class EditJobPage extends StatefulWidget {
  const EditJobPage({Key key,@required this.database,@required this.job}):super(key: key);
  final Database database;
  final Job job;
  static Future<void> show(BuildContext context,{Database database,Job job}) async{
    //context of job page

    await Navigator.of(context,rootNavigator:true ).push(
      MaterialPageRoute(builder: (context) => EditJobPage(
        job: job,
        database: database,
      ),
      fullscreenDialog: true,)
    );
  }
  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey=GlobalKey<FormState>();
  String _name;
  int _rateperHour;
  @override
  void initState(){
    super.initState();
    if(widget.job!=null)
      {
        _name=widget.job.name;
        _rateperHour=widget.job.ratePerHour;
      }
  }
  bool _validateAndSaveForm(){
    final form=_formKey.currentState;
    if(form.validate())
      {
        form.save();
        return true;
      }
    return false;

  }
  Future<void> _submit()async{
   if(_validateAndSaveForm())
   {
     try{
       final jobs=await widget.database.jobsStream().first;//gets the first(most up to date value on the stream
      final allNames=jobs.map((e) => (e.name)).toList();
      if(widget.job!=null)
        {
          allNames.remove(widget.job.name);
        }
      if(allNames.contains(_name))
        {
          PlatformAlertDialog(
              title: 'Name already used',
              content: 'Please choose a different name',
              defaultActionText: 'OK',).show(context);
        }
      else
      {
        final id=widget.job?.id??documentIdFromCurrentDate();
        final job=Job(name: _name, ratePerHour: _rateperHour,id: id);
        await widget.database.setJob(job);
        Navigator.of(context).pop();
      }
     } on PlatformException catch(e){
       PlatformExceptionAlertDialog(
         title:'Operation failed',
         exception:e,
       ).show(context);
     }

   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2.0,
          title: Center(child: Text(
            widget.job==null? 'New Job':'Edit Job')),
        actions: [
          FlatButton(
            onPressed: _submit,
              child:Text(
                'Save',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ), )
        ],
      ),
        body: _buildContent(),
    );
  }

Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
         child: Padding(
           padding: EdgeInsets.all(16.0),
           child:_buildForm(),
         ),
        ),
      ),
    );
}

 Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _buildFormChildren(),
    ),
    );
 }

 List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Job name'
        ),
        initialValue: _name,
        validator: (value) => value.isNotEmpty?null:'Name can\'t be empty',
        onSaved: (value)=> _name=value,
      ),
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Rate per hour',
        ),
        initialValue:_rateperHour!=null? '$_rateperHour':null,
        onSaved: (value)=> _rateperHour =int.tryParse(value)??0,
        keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false,),
      ),
    ];
 }
}
