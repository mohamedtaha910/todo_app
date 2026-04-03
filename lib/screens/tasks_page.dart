import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/constant.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.tasksList,
    required this.name,
    required this.icon,
    required this.iconColor,
  });
  final Widget tasksList;
  final String name;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomHeader(
              title: name,
              height: 200,
              icon: Icon(icon, size: 32, color: iconColor,),
              iconColor: iconColor.withAlpha(38),
              iconPadding: 10,
              backgroundColor: kStatisticsColor,
              headerHeight: 60,
            ),
            Transform.translate(
              offset: Offset(0, -65),
              child: tasksList
            ),
          ],
        ),
      ),
    );
  }
}
