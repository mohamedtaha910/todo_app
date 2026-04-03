import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/categories_header.dart';
import 'package:todo_app/components/task_item.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/helper/helper.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/add_task_page.dart';
import 'package:todo_app/screens/no_notes_page.dart';
import 'package:todo_app/services/tasks_services.dart';
import 'package:todo_app/shimmers/shimmer_list.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({
    super.key,
    required this.category,
    required this.ownerId,
  });
  final CategoryModel category;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy ').format(date);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CategoriesHeader(formattedDate: formattedDate, category: category),
            Transform.translate(
              offset: Offset(0, -65),
              child: Container(
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: TaskServices().tasks
                      .orderBy(kTaskDate, descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<TaskModel> tasksList = [];

                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        var document = snapshot.data!.docs[i];
                        if (document['ownerId'] != ownerId) {
                          continue;
                        } else {
                          Timestamp firestoreTimestamp = document[kTaskDate]!;
                          if (firestoreTimestamp.toDate().day == date.day &&
                              firestoreTimestamp.toDate().month == date.month &&
                              firestoreTimestamp.toDate().year == date.year) {
                            tasksList.add(
                              TaskModel.fromFirestore(
                                document.data() as Map<String, dynamic>,
                                document.id,
                              ),
                            );
                          }
                        }
                      }

                      List<TaskModel> categoryTasks = tasksList
                          .where((task) => task.category == category.name)
                          .toList(); // Filter tasks by categoryTasks

                      Helper().sortByStartTime(categoryTasks);

                      return categoryTasks.isEmpty
                          ? NoNotesPage(text: 'No Tasks yet !')
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: categoryTasks.length,
                              itemBuilder: (context, index) =>
                                  TaskItem(task: categoryTasks[index]),
                            );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      return ShimmerList();
                    }
                  },
                ),
              ),
            ),
            // SizedBox(height: 200,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(
                selectedCategoryModel: category,
                ownerId: ownerId,
              ),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        // backgroundColor: const Color.fromARGB(255, 166, 205, 244),
        // backgroundColor: const Color.fromARGB(255, 191, 170, 248),
        backgroundColor: category.color.withAlpha(250),
        child: Icon(Icons.edit_note_rounded, size: 32),
      ),
    );
  }
}
