// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/task_model.dart';

class TaskServices {
  final CollectionReference tasks = FirebaseFirestore.instance.collection(
    kTasksCollection,
  );

  List<TaskModel> tasksList = [];

  
  Future<void> addTask(TaskModel task) async {
    tasks.add({
      'id': task.id,
      kTaskTitle: task.title,
      kTaskDate: task.date,
      kTaskStartTime: task.startTime,
      kTaskEndTime: task.endTime,
      kDescription: task.description,
      kCategory: task.category,
      kTaskColor: task.color.value,
      kTaskisCompleted: task.isCompleted,
      'ownerId': task.ownerId
    });
  }

  // Future<List<TaskModel>> fetchTasks() async {
  // QuerySnapshot querySnapshot = await tasks.get();

  // List<TaskModel> tasksList = [];

  // for (var doc in querySnapshot.docs) {
  //   tasksList.add(
  //     TaskModel.fromFirestore(
  //       doc.data() as Map<String, dynamic>,
  //       doc.id,
  //     ),
  //   );
  // }

  // return tasksList;
// }

  Future<void> deleteTask(TaskModel task) async {
    await tasks.doc(task.id).delete();
  }

  Future<void> finishTask(TaskModel task) async {
    await tasks.doc(task.id).update({kTaskisCompleted: !task.isCompleted});
  }

  Future<void> updateTask(TaskModel task) async {
    await tasks.doc(task.id).update(task.toJson());
  }
}
