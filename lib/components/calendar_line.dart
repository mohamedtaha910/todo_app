import 'package:flutter/material.dart';

class CalendarLine extends StatelessWidget {
  const CalendarLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32.0),
      decoration: BoxDecoration(
        color: Color(0XFF9eacbc).withAlpha(140),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
