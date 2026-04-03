import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class Helper {
  TimeOfDay stringToTimeOfDay(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (parts[1] == 'PM' && hour != 12) {
      hour += 12;
    }
    if (parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  void sortByStartTime(List<TaskModel> arr) {
    arr.sort((a, b) {
      TimeOfDay timeA = Helper().stringToTimeOfDay(a.startTime);
      TimeOfDay timeB = Helper().stringToTimeOfDay(b.startTime);

      int minutesA = timeA.hour * 60 + timeA.minute;
      int minutesB = timeB.hour * 60 + timeB.minute;

      return minutesA.compareTo(minutesB);
    });
  }
}
