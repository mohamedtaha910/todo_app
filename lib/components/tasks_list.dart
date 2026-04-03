import 'package:flutter/material.dart';
import 'package:todo_app/components/task_item.dart';
import 'package:todo_app/models/task_model.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key, required this.tasksList});
  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ]
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tasksList.length,
        itemBuilder: (context, index) => TaskItem(task: tasksList[index]),
      ),
    );
  }
}
