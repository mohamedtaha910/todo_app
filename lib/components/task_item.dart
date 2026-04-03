// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/edit_task_page.dart';
import 'package:todo_app/services/tasks_services.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  // bool isCompleted = false;
  late String formatedStartTime;
  late String formatedEndTime;
  CategoryModel? category;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    category = CategoriesGrid.categories
        .where((element) => element.name == widget.task.category)
        .first;

    formatedStartTime = widget.task.startTime.length < 8
        ? '0${widget.task.startTime}'
        : widget.task.startTime;
    formatedEndTime = widget.task.endTime.length < 8
        ? '0${widget.task.endTime}'
        : widget.task.endTime;

    return GestureDetector(
      // dragStartBehavior: DragStartBehavior.start,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditTaskPage(task: widget.task),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),

              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          border: BorderDirectional(
            start: BorderSide(
              color: widget.task.isCompleted ? Colors.grey : category!.color,
              width: 6,
            ),

            // end: BorderSide(
            //   color: widget.task.isCompleted ? Colors.grey : category!.color,
            //   width: 0.1,
            // ),
            // top: BorderSide(
            //   color: widget.task.isCompleted ? Colors.grey : category!.color,
            //   width: 0.1,
            // ),
            // bottom: BorderSide(
            //   color: widget.task.isCompleted ? Colors.grey : category!.color,
            //   width: 0.1,
            // ),
          ),
          borderRadius: BorderRadius.circular(8),
          color: kBackgroundColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  ' ${widget.task.title.length > 30 ? '${widget.task.title.substring(0, 30)}...' : widget.task.title}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: widget.task.isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    TaskServices().finishTask(widget.task);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: widget.task.isCompleted
                          ? Colors.grey.withOpacity(0.2)
                          : category!.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: widget.task.isCompleted
                            ? Colors.grey
                            : category!.color,
                        width: 1,
                      ),
                    ),
                    child: widget.task.isCompleted
                        ? Icon(Icons.check, size: 16, color: category!.color)
                        : SizedBox(width: 16, height: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SvgPicture.asset('assets/icons/calendar.svg', height: 20),

                Text(
                  ' $formatedStartTime to $formatedEndTime',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.task.isCompleted
                        ? Colors.grey.withAlpha(50)
                        : category!.color.withAlpha(50),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.task.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.task.isCompleted
                          ? Colors.grey
                          : category!.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),

                GestureDetector(
                  onTap: () {
                    deleteTask();
                  },
                  child: Image.asset(
                    'assets/icons/trash3_black.png',
                    height: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 199, 216, 200),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 213, 59, 47),
            ),
            onPressed: () {
              TaskServices().deleteTask(widget.task);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
