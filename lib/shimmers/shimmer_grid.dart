import 'package:flutter/material.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/components/category_item.dart';
// import 'package:todo_app/screens/categories_screen.dart';

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
                color: CategoriesGrid.categories[index].color,
                iconColor: CategoriesGrid.categories[index].iconColor,
                iconPath: CategoriesGrid.categories[index].iconPath,
                taskCount: 0,
                name: CategoriesGrid.categories[index].name,
              );
            },
          );
  }
}