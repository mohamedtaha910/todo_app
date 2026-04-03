import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/category_item.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/categories_screen.dart';
// import 'package:todo_app/screens/no_notes_page.dart';
import 'package:todo_app/services/tasks_services.dart';
import 'package:todo_app/shimmers/shimmer_grid.dart';

class CategoriesGrid extends StatefulWidget {
  const CategoriesGrid({super.key, required this.ownerId});
  static List<CategoryModel> categories = [
    CategoryModel(
      id: 0,
      name: 'Health',
      iconPath: 'assets/icons/health.svg',
      taskCount: 6,
      color: Color(0xFF7990F8),
      iconColor: const Color.fromARGB(255, 66, 93, 246),
    ),
    CategoryModel(
      id: 1,
      name: 'Work',
      iconPath: 'assets/icons/work2.svg',
      taskCount: 6,
      // color: Color(0xFFFFB74D),
      color: Color.fromARGB(255, 250, 183, 83),
      iconColor: Colors.deepOrangeAccent,
    ),
    CategoryModel(
      id: 2,
      name: 'Mental Health',
      iconPath: 'assets/icons/mental_health.svg',
      taskCount: 6,
      color: Color(0xFF81C784),
      iconColor: const Color.fromARGB(255, 59, 160, 63),
    ),
    CategoryModel(
      id: 3,
      name: 'Other',
      iconPath: 'assets/icons/other.svg',
      taskCount: 6,
      color: Color(0xFFA593E0),
      iconColor: Colors.purple,
    ),
  ];
  final String ownerId;
  @override
  State<CategoriesGrid> createState() => _CategoriesGridState();
}

class _CategoriesGridState extends State<CategoriesGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskServices().tasks
          .orderBy(kTaskDate, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerGrid();
        } else if (snapshot.hasData) {
          List<TaskModel> tasksList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var document = snapshot.data!.docs[i];
            if (document['ownerId'] != widget.ownerId) {
              continue;
            } else {
              Timestamp firestoreTimestamp = document[kTaskDate]!;
              if (firestoreTimestamp.toDate().day == DateTime.now().day &&
                  firestoreTimestamp.toDate().month == DateTime.now().month &&
                  firestoreTimestamp.toDate().year == DateTime.now().year) {
                tasksList.add(
                  TaskModel.fromFirestore(
                    document.data() as Map<String, dynamic>,
                    document.id,
                  ),
                );
              }
            }
          }
          for (int i = 0; i < tasksList.length; i++) {
            if (tasksList[i].ownerId != widget.ownerId) {
              tasksList.removeAt(i);
            }
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.9,
            ),
            itemCount: CategoriesGrid.categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoriesPage(
                      ownerId: widget.ownerId,
                      category: CategoriesGrid.categories[index],
                    ),
                  ),
                ),
                color: CategoriesGrid.categories[index].color,
                iconColor: CategoriesGrid.categories[index].iconColor,
                iconPath: CategoriesGrid.categories[index].iconPath,
                taskCount: tasksList
                    .where(
                      (task) =>
                          task.category ==
                          CategoriesGrid.categories[index].name,
                    )
                    .toList()
                    .length,
                name: CategoriesGrid.categories[index].name,
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          return ShimmerGrid();
        }
      },
    );
  }
}
