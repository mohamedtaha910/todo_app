import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/components/edit_text_feild.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/helper/helper.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/tasks_services.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key, required this.task});
  final TaskModel task;

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  List<CategoryModel> categories = CategoriesGrid.categories;
  late CategoryModel selectedCategory;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? selectedDate;
  String? title;
  @override
  void initState() {
    selectedCategory = CategoriesGrid.categories
        .where((i) => i.name == widget.task.category)
        .toList()
        .first;
    startTime = Helper().stringToTimeOfDay(widget.task.startTime);
    endTime = Helper().stringToTimeOfDay(widget.task.endTime);
    selectedDate = widget.task.date;
    title = widget.task.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            /// ================== HEADER ==================
            CustomHeader(
              height: 180,
              backgroundColor: kSecondaryColor,
              title: 'Edit Task',
              icon: Image.asset('assets/icons/edit3.png', height: 32),
              iconColor: Colors.white10,
              iconPadding: 10,
            ),

            /// ================== CARD ==================
            Transform.translate(
              offset: Offset(0, -60),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12),

                      EditTextFeild(
                        text: widget.task.title,
                        maxLines: 1,
                        onchanged: (value) {
                          title = value;
                        },
                      ),

                      SizedBox(height: 24),

                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12),

                      // SizedBox(height: 120, child: CategoriesList()),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 6,
                          childAspectRatio: 3.3,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = categories[index];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: categories[index].color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),

                                border: selectedCategory == categories[index]
                                    ? Border.all(
                                        color: categories[index].color,
                                        width: 1.5,
                                      )
                                    : Border.all(
                                        color: Colors.transparent,
                                        width: 1.5,
                                      ),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index].name,
                                  style: TextStyle(
                                    color: categories[index].color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          GestureDetector(
                            onTap: pickDate,
                            child: buildDateContainer(
                              selectedDate == null
                                  ? "Choose date"
                                  : DateFormat.yMMMd().format(selectedDate!),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          // SizedBox(height: 8),
                          Spacer(),
                          GestureDetector(
                            onTap: pickStartTime,
                            child: buildTimeContainer(
                              startTime == null
                                  ? "start time"
                                  : startTime!.format(context),
                            ),
                          ),
                          Spacer(),
                          // Text(
                          //   '  to  ',
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.black54,
                            size: 24,
                          ),
                          Spacer(),

                          GestureDetector(
                            onTap: pickEndTime,
                            child: buildTimeContainer(
                              endTime == null
                                  ? "end time"
                                  : endTime!.format(context),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),

                      SizedBox(height: 24),
                      Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12),
                      EditTextFeild(
                        text: widget.task.description,
                        maxLines: 5,
                        onchanged: (value) {
                          widget.task.description = value;
                        },
                      ),

                      SizedBox(height: 24),
                      CustomButton(
                        borderRadius: 25,
                        text: 'Save',
                        onTap: () {
                          widget.task.date = selectedDate!;
                          widget.task.title = title!;
                          widget.task.category = selectedCategory.name;
                          widget.task.startTime = startTime!.format(context);
                          widget.task.endTime = endTime == null
                              ? "12:00 AM"
                              : endTime!.format(context);
                          widget.task.color = selectedCategory.color;
                          if (formKey.currentState!.validate()) {
                            TaskServices().updateTask(widget.task);
                            Navigator.of(context).pop();
                          } else {
                            autoValidateMode = AutovalidateMode.always;
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // to choose start time
  Future<void> pickStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        startTime = picked;
        endTime = null; // نصفر النهاية لو غير البداية
      });
    }
  }

  Future<void> pickEndTime() async {
    if (startTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Select start time first")));
      return;
    }

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime!,
    );

    if (picked != null) {
      // نحول الاتنين لـ دقائق للمقارنة
      int startMinutes = startTime!.hour * 60 + startTime!.minute;
      int endMinutes = picked.hour * 60 + picked.minute;

      if (endMinutes <= startMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("End time must be after start time")),
        );
        return;
      }

      setState(() {
        endTime = picked;
      });
    }
  }

  Widget buildTimeContainer(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.task.date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget buildDateContainer(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }
}
