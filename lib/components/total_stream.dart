import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/tasks_list.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/no_notes_page.dart';
import 'package:todo_app/services/tasks_services.dart';
import 'package:todo_app/shimmers/shimmer_list.dart';

class TotalStream extends StatelessWidget {
  const TotalStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskServices().tasks
          .orderBy(kTaskDate, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerList();
        }
        if (snapshot.hasData) {
          List<TaskModel> tasksList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var document = snapshot.data!.docs[i];
            if (document['ownerId'] !=
                FirebaseAuth.instance.currentUser!.email) {
              continue;
            } else {
              tasksList.add(
                TaskModel.fromFirestore(
                  document.data() as Map<String, dynamic>,
                  document.id,
                ),
              );
            }
          }

          return tasksList.isEmpty
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: NoNotesPage(text: 'No Tasks yet !'),
                )
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
