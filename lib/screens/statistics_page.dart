import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/bar_char.dart';
import 'package:todo_app/components/bar_info.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/components/horizintal_line.dart';
import 'package:todo_app/components/statistics_grid.dart';
import 'package:todo_app/components/statistics_row.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/tasks_services.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String ownerId = FirebaseAuth.instance.currentUser!.email!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomHeader(
              title: 'Statistics',
              height: 200,
              icon: Image.asset('assets/icons/bar_chart.png', height: 28),
              iconColor: Colors.white10,
              iconPadding: 10,
              backgroundColor: kStatisticsColor,
              headerHeight: 60,
            ),

            Transform.translate(
              offset: Offset(0, -65),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: StreamBuilder<QuerySnapshot>(
                  stream: TaskServices().tasks
                      .orderBy(kTaskDate, descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      List<TaskModel> tasksList = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        var document = snapshot.data!.docs[i];
                        if (document['ownerId'] != ownerId) {
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

                      List<TaskModel> completedTasks = tasksList
                          .where((task) => task.isCompleted == true)
                          .toList();
                      List<TaskModel> pendingTasks = tasksList
                          .where((task) => task.isCompleted == false)
                          .toList();
                      List<TaskModel> todayTasks = tasksList
                          .where(
                            (task) =>
                                task.date.day == DateTime.now().day &&
                                task.date.month == DateTime.now().month &&
                                task.date.year == DateTime.now().year,
                          )
                          .toList();
                      List<TaskModel> todayCompleted = todayTasks
                          .where((task) => task.isCompleted == true)
                          .toList();
                      List<TaskModel> todayPending = todayTasks
                          .where((task) => task.isCompleted == false)
                          .toList();

                      List<TaskModel> lastWeekTasks = tasksList
                          .where(
                            (task) =>
                                task.date.isAfter(
                                  DateTime.now().subtract(Duration(days: 7)),
                                ) &&
                                task.date.isBefore(DateTime.now()),
                          )
                          .toList();
                      List<TaskModel> lastWeekCompleted = lastWeekTasks
                          .where((task) => task.isCompleted == true)
                          .toList();
                      List<TaskModel> lastWeekPending = lastWeekTasks
                          .where((task) => task.isCompleted == false)
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatisticsGrid(
                            totalTasks: tasksList,
                            completedTasks: completedTasks,
                            pendingTasks: pendingTasks,
                            todayTasks: todayTasks,
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Today ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            // height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              children: [
                                StatisticsRow(
                                  name: 'Total',
                                  icon: Icons.notes,
                                  number: todayTasks.length.toString(),
                                ),
                                HorizintalLine(),
                                StatisticsRow(
                                  name: 'Completed',
                                  icon: Icons.checklist_rounded,
                                  number: todayCompleted.length.toString(),
                                ),
                                HorizintalLine(),
                                StatisticsRow(
                                  name: 'Pending',
                                  icon: Icons.pending_actions_rounded,
                                  number: todayPending.length.toString(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Last Week ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 16,
                            ),
                            // height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kBackgroundColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Column(
                              children: [
                                StatisticsRow(
                                  name: 'Total',
                                  icon: Icons.notes,
                                  number: lastWeekTasks.length.toString(),
                                ),
                                HorizintalLine(),
                                StatisticsRow(
                                  name: 'Completed',
                                  icon: Icons.checklist_rounded,
                                  number: lastWeekCompleted.length.toString(),
                                ),
                                HorizintalLine(),
                                StatisticsRow(
                                  name: 'Pending',
                                  icon: Icons.pending_actions_rounded,
                                  number: lastWeekPending.length.toString(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Last Week Progress',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          BarInfo(),
                          SizedBox(height: 24),
                          CustomBarChart(
                            completedTasks: lastWeekCompleted.length.toDouble(),
                            pendingTasks: lastWeekPending.length.toDouble(),
                            totalTasks: lastWeekTasks.length.toDouble(),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Total Progress',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 16),
                          BarInfo(),
                          SizedBox(height: 24),
                          CustomBarChart(
                            completedTasks: completedTasks.length.toDouble(),
                            pendingTasks: pendingTasks.length.toDouble(),
                            totalTasks: tasksList.length.toDouble(),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.black54,
                            size: 40,
                          ),
                          Text(
                            'Something went wrong',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),

            // SizedBox(height: 200,)
          ],
        ),
      ),
    );
  }
}
