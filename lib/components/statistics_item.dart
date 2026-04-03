import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';
// import 'package:svg_flutter/svg.dart';

class StatisticsItem extends StatelessWidget {
  const StatisticsItem({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.taskCount,
    required this.name,
    required this.onTap,
  });

  final Color iconColor;
  final IconData icon;
  final int taskCount;
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:  16 , vertical: 8),
        // height: 100,
        width: 200,
        decoration: BoxDecoration(
          // border: Border.all(color:itemColor , width: 1.5),
          borderRadius: BorderRadius.circular(12),
          color: kBackgroundColor,
          // color: Colors.deepPurpleAccent.withOpacity(0.5),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 4,
          //     offset: Offset(0, 4),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconColor.withAlpha(50),
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
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
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
