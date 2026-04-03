import 'package:flutter/material.dart';

class BarInfo extends StatelessWidget {
  const BarInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // margin: EdgeInsets.only(top: 12),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Text(
          'Completed',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 40),
        Container(
          // margin: EdgeInsets.only(top: 12),
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
        ),
        SizedBox(width: 12),
        Text(
          'Pending',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
