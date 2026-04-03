import 'package:flutter/material.dart';

class StatisticsRow extends StatelessWidget {
  const StatisticsRow({super.key, required this.name, required this.icon, required this.number});
  final String name;
  final IconData icon;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black54, size: 24),
        SizedBox(width: 12),
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(flex: 10),
        Text(
          number,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
