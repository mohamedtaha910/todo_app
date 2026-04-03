import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/components/main_header.dart';
import 'package:todo_app/components/tasks_stream.dart';
import 'package:todo_app/constant.dart';

import 'package:todo_app/screens/add_task_page.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserCredential user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? midnightTimer;

  @override
  void initState() {
    super.initState();
    scheduleMidnightUpdate();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();

    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeader(date: date),
            Transform.translate(
              offset: Offset(0, -60),
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CategoriesGrid(ownerId: widget.user.user!.email!),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TasksStream(date: date),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(
                selectedCategoryModel: CategoriesGrid.categories.last,
                ownerId: widget.user.user!.email!,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),

        backgroundColor: const Color.fromARGB(255, 184, 161, 249),
        child: Icon(Icons.edit_note_rounded, size: 32),
      ),
    );
  }

  /// Schedule the midnight update
  void scheduleMidnightUpdate() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);

    final duration = nextMidnight.difference(now);

    midnightTimer = Timer(duration, () {
      setState(() {});
      scheduleMidnightUpdate();
    });
  }
}
