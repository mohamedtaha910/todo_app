import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/tasks_list.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/helper/helper.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/no_notes_page.dart';
import 'package:todo_app/services/tasks_services.dart';
import 'package:todo_app/shimmers/shimmer_list.dart';

class TasksStream extends StatefulWidget {
  const TasksStream({super.key, required this.date});
  final DateTime date;

  @override
  State<TasksStream> createState() => _TasksStreamState();
}

class _TasksStreamState extends State<TasksStream> {
  @override
  Widget build(BuildContext context) {
    

    return StreamBuilder<QuerySnapshot>(
      stream: TaskServices().tasks
          .orderBy(kTaskDate, descending: false )
          .snapshots(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerList();
        }
        if (snapshot.hasData) {
          DateTime targetDate = widget.date;
          List<TaskModel> tasksList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var document = snapshot.data!.docs[i];
            if (document['ownerId'] !=
                FirebaseAuth.instance.currentUser!.email) {
              continue;
            } else {
              Timestamp firestoreTimestamp = document[kTaskDate]!;
              if (firestoreTimestamp.toDate().day == targetDate.day &&
                  firestoreTimestamp.toDate().month == targetDate.month &&
                  firestoreTimestamp.toDate().year == targetDate.year) {
                tasksList.add(
                  TaskModel.fromFirestore(
                    document.data() as Map<String, dynamic>,
                    document.id,
                  ),
                );
              }
            }
          }
          Helper().sortByStartTime(tasksList);


          return tasksList.isEmpty
              ? NoNotesPage(text: 'No Tasks yet !',)
              : TasksList(tasksList: tasksList);
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          return ShimmerList();
        }
      },
    );
  }
}
