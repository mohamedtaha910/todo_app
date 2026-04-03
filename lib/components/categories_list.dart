import 'package:flutter/material.dart';
import 'package:todo_app/components/caregories_grid.dart';
import 'package:todo_app/models/category_model.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoryModel selectedCategory = CategoriesGrid.categories.last;
  bool isSelected = false;
  List<CategoryModel> categories = CategoriesGrid.categories;
  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
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
          padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
           margin: EdgeInsets.symmetric(vertical: 4 , horizontal: 8),
          decoration: BoxDecoration(
            color: categories[index].color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            
            border:  selectedCategory == categories[index] ? Border.all(color: categories[index].color , width: 1.5) : Border.all(color: Colors.transparent , width: 1.5),
          ),
          child: Center(child: Text(categories[index].name , style: TextStyle(color: categories[index].color , fontWeight: FontWeight.w500),)),
         ),
       );
     });
  }
}