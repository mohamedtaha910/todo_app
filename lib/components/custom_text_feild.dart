import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
    required this.hintText,
    required this.maxLines,
    this.onchanged,
    this.autoFocus = false,
  });
  final String hintText;
  final int maxLines;
  final void Function(String)? onchanged;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty && maxLines == 1) {
          return 'feild is required';
        } else {
          return null;
        }
      },
      autofocus: autoFocus ,
      onChanged: onchanged,
      cursorColor: kSecondaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,

        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
