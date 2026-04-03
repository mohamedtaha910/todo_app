import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final String iconPath;
  final int taskCount;
  final Color color;
  final Color iconColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.taskCount,
    required this.color,
    required this.iconColor,
  });
}
