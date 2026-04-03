import 'package:flutter/material.dart';

class HorizintalLine extends StatelessWidget {
  const HorizintalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0XFF9eacbc).withAlpha(140),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}