import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/components/calendar_line.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/components/tasks_stream.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/add_task_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              height: 180,
              backgroundColor: kCalendarColor,
              title: 'Calender View',
              icon: Image.asset('assets/icons/calendar4.png', height: 30),
              iconColor: const Color.fromARGB(255, 78, 101, 177),
              iconPadding: 10,
            ),

            Transform.translate(
              offset: Offset(0, -53),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 238, 249),
                      borderRadius: BorderRadius.circular(12),
                      border: BorderDirectional(
                        start: BorderSide(
                          // color: kSecondaryColor.withAlpha(200),
                          color: Colors.grey,
                          width: 3,
                        ),
                        end: BorderSide(
                          // color: kSecondaryColor.withAlpha(200),
                          color: Colors.grey,
                          width: 3,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TableCalendar(
                      rowHeight: 49,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        weekdayStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onFormatChanged: (format) {
                        if (mounted) {
                          setState(() {
                            calendarFormat = format;
                          });
                        }
                      },
                      calendarFormat: calendarFormat,
                      focusedDay: today,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2030),

                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDay, day);
                      },

                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          this.selectedDay = selectedDay;
                          today = focusedDay;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 28),
                  CalendarLine(),

                  SizedBox(height: 16),
                  TasksStream(date: selectedDay),
                ],
              ),
            ),

            SizedBox(height: 60),
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
                ownerId: FirebaseAuth.instance.currentUser!.email!,
                selectedDateTime: selectedDay,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        // backgroundColor: const Color.fromARGB(255, 166, 205, 244),
        // backgroundColor: const Color.fromARGB(255, 184, 161, 249),
        backgroundColor: const Color.fromARGB(255, 152, 168, 245),

        child: Icon(Icons.edit_note_rounded, size: 32, color: Colors.black54),
      ),
    );
  }
}
