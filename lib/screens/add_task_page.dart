import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/components/custom_text_feild.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/tasks_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    required this.selectedCategoryModel,
    required this.ownerId,
    this.selectedDateTime,
  });
  final CategoryModel selectedCategoryModel;
  final String ownerId;
  final DateTime? selectedDateTime;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isSelected = false;
  List<CategoryModel> categories = CategoriesGrid.categories;

  GlobalKey<FormState> formKey = GlobalKey();
  String? taskName;
  String? taskDescription;
  Color taskColor = kSecondaryColor;

  TimeOfDay? startTime;
  TimeOfDay? endTime;
  DateTime? selectedDate;
  String? ownerId;
  CategoryModel? selectedCategory;

  @override
  void initState() {
    selectedDate = widget.selectedDateTime ?? DateTime.now();
    selectedCategory = widget.selectedCategoryModel;

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
              title: 'Add New Task',
              icon: Image.asset('assets/icons/add7.png', height: 33),
              iconColor: Colors.white10,
              iconPadding: 9,
            ),

            /// ================== CARD ==================
            Transform.translate(
              offset: Offset(0, -65),
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
                  autovalidateMode: autovalidateMode,
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

                      CustomTextFeild(
                        hintText: 'task title',
                        maxLines: 1,
                        autoFocus: true,
                        onchanged: (value) {
                          taskName = value;
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
                                color: categories[index].color.withAlpha(50),
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

                      // SizedBox(height: 12),
                      SizedBox(height: 24),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 8),
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

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
                      CustomTextFeild(
                        hintText: 'Additional notes about the task',
                        maxLines: 5,
                        onchanged: (value) {
                          taskDescription = value;
                        },
                      ),

                      SizedBox(height: 24),
                      CustomButton(
                        borderRadius: 25,

                        text: 'Add Task',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            ownerId = widget.ownerId;
                            TaskModel task = TaskModel(
                              ownerId: ownerId!,
                              date: selectedDate == null
                                  ? DateTime.now()
                                  : selectedDate!,
                              title: taskName!,
                              description: taskDescription ?? '',
                              category: selectedCategory!.name,
                              startTime: startTime == null
                                  ? '12:00 AM'
                                  : startTime!.format(context),
                              endTime: endTime == null
                                  ? '12:00 AM'
                                  : endTime!.format(context),
                              color: selectedCategory!.color,
                              isCompleted: false,
                            );

                            TaskServices().addTask(task);
                            Navigator.pop(context);
                          } else {
                            autovalidateMode = AutovalidateMode.always;
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      initialDate: DateTime.now(),
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
