import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black54, size: 24),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex: 10),
          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 16),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
