import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.marginHorizontal = 0,
    this.verticalPadding = 12,
    this.borderRadius = 12,
    this.color = kSecondaryColor,
  });
  final String text;
  final double marginHorizontal;
  final double verticalPadding;
  final double borderRadius;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          // horizontal: 24,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
