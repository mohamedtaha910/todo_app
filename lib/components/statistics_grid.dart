import 'package:flutter/material.dart';
import 'package:todo_app/components/completed_stream.dart';
import 'package:todo_app/components/pending_stream.dart';
import 'package:todo_app/components/statistics_item.dart';
import 'package:todo_app/components/tasks_stream.dart';
import 'package:todo_app/components/total_stream.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/tasks_page.dart';

class StatisticsGrid extends StatefulWidget {
  const StatisticsGrid({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.todayTasks,
  });

  final List<TaskModel> totalTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> pendingTasks;
  final List<TaskModel> todayTasks;

  @override
  State<StatisticsGrid> createState() => _StatisticsGridState();
}

class _StatisticsGridState extends State<StatisticsGrid> {
  @override
  Widget build(BuildContext context) {
    List<Widget> statisticsList = [
      StatisticsItem(
        iconColor: Colors.blue,
        icon: Icons.notes_rounded,
        taskCount: widget.totalTasks.length,
        name: 'Total',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TasksPage(
                icon: Icons.notes_rounded,
                name: 'Total',
                tasksList: TotalStream(),
                iconColor: Colors.blue,
              ),
            ),
          );
        },
      ),
      StatisticsItem(
        iconColor: Colors.green,
        icon: Icons.checklist_rounded,
        taskCount: widget.completedTasks.length,
        name: 'Completed',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TasksPage(
                icon: Icons.checklist_rounded,
                name: 'Completed',
                tasksList: CompletedStream(),
                iconColor: Colors.green,
              ),
            ),
          );
        },
      ),

      StatisticsItem(
        iconColor: const Color.fromARGB(255, 248, 94, 145),
        icon: Icons.pending_actions_rounded,
        taskCount: widget.pendingTasks.length,
        name: 'Pending',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TasksPage(
                icon: Icons.pending_actions_rounded,
                name: 'Pending',
                tasksList: PendingStream(),
                iconColor: const Color.fromARGB(255, 248, 94, 145),
              ),
            ),
          );
        },
      ),
      StatisticsItem(
        iconColor: Colors.orange,
        icon: Icons.calendar_month_rounded,
        taskCount: widget.todayTasks.length,
        name: 'Today',
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TasksPage(
                icon: Icons.calendar_month_rounded,
                name: 'Today',
                tasksList: TasksStream(date: DateTime.now()),
                iconColor: Colors.orange,
              ),
            ),
          );
        },
      ),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.67,
      ),
      itemCount: statisticsList.length,
      itemBuilder: (context, index) => statisticsList[index],
    );
  }
}
