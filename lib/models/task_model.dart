// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class TaskModel {
  String? id;
  String title;
  String description;
  String category;
  DateTime date;
  String startTime;
  String endTime;
  Color color;
  bool isCompleted;
  String ownerId;

  TaskModel({
    this.id,
    this.isCompleted = false,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.ownerId,
  });

  ///  from Firestore
  factory TaskModel.fromFirestore(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return TaskModel(
      id: documentId,
      title: json[kTaskTitle],
      description: json[kDescription],
      category: json[kCategory],
      date: json[kTaskDate].toDate(),
      startTime: json[kTaskStartTime],
      endTime: json[kTaskEndTime],
      color: Color(json[kTaskColor]),
      isCompleted: json[kTaskisCompleted] ?? false,
      ownerId: json['ownerId'],
    );
  }

  ///  to Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      kTaskTitle: title,
      kDescription: description,
      kCategory: category,
      kTaskDate: date,
      kTaskStartTime: startTime,
      kTaskEndTime: endTime,
      kTaskColor: color.value, //=>
      kTaskisCompleted: isCompleted,
      'ownerId': ownerId
    };
  }
}
