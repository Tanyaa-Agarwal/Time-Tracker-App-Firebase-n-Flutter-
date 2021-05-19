import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_app/app/home/job_entries/job_entries_page.dart';
import 'package:time_tracker_app/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_app/app/home/jobs/empty_content.dart';
import 'package:time_tracker_app/app/home/jobs/job_list_tile.dart';
import 'package:time_tracker_app/app/home/jobs/list_items_buillder.dart';
import 'package:time_tracker_app/app/home/models/job.dart';
import 'package:time_tracker_app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/common_widgets/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/services/database.dart';
class JobsPage extends StatelessWidget {



 Future<void> _delete(BuildContext context, job) async{
    try{
    final database=Provider.of<Database>(context);
    await database.deleteJob(job);
    }on PlatformException catch(e){
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: [
          IconButton(
              icon: Icon(Icons.add,color: Colors.white,),
              onPressed: () => EditJobPage.show(context,database:Provider.of<Database>(context)),
            ),
        ],
      ),
      body: _buildContents(context),

    );
  }

 Widget  _buildContents(BuildContext context) {
    final database=Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
        builder: (context,snapshot){
        return ListItemsBuilder(snapshot: snapshot,
            itemBuilder:(context,job)=> Dismissible(
              key: Key('job-${job.id}'),
              background: Container(color: Colors.red,),
              direction: DismissDirection.endToStart,
              onDismissed: (direction)=>_delete(context,job),
              child: JobListTile(
          job: job,
        onTap: ()=> JobEntriesPage.show(context,job),),
            ));
        // if(snapshot.hasData)
        //   {
        //     final jobs=snapshot.data;
        //     if(jobs.isNotEmpty){
        //       final children=jobs.map((job) => JobListTile(
        //         job:job,
        //         onTap: ()=>EditJobPage.show(context,job: job),
        //       )).toList();
        //       return ListView(
        //         children: children,
        //       );
        //     }
        //     return EmptyContent();
        //
        //   }
        // if(snapshot.hasError)
        //   return Center(
        //     child: Text('Some error occured'),
        //   );
        // return Center(
        //   child: CircularProgressIndicator(),
        // );
        });
 }


}
