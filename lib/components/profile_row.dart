import 'package:flutter/material.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.arrowColor,
  });
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color arrowColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withAlpha(240),
              // borderRadius: BorderRadius.circular(8),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(flex: 10),
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: title == 'Logout'
                  ? Colors.red.withAlpha(50)
                  : Colors.grey.withAlpha(100),
              // borderRadius: BorderRadius.circular(8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: arrowColor,
              size: 24,
            ),
          ),
          // SizedBox(width: 8),
        ],
      ),
    );
  }
}
