import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.color,
    required this.iconColor,
    required this.iconPath,
    required this.taskCount,
    required this.name,
    required this.onTap
  });

  final Color color;
  final Color iconColor;
  final String iconPath;
  final int taskCount;
  final String name;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:  16 ,),
        // height: 100,
        // width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
          // color: Colors.deepPurpleAccent.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              iconPath,
              height: name == 'Work' ? 28 : 24,
              width: name == 'Work' ? 28 : 24,
              color: iconColor,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '$taskCount ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
