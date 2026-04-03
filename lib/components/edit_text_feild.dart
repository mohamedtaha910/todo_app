import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class EditTextFeild extends StatefulWidget {
  const EditTextFeild({
    super.key,
    required this.text,
    required this.maxLines,
    this.onchanged,
    this.autoFocus = false,
  });
  final String text;
  final int maxLines;
  final void Function(String)? onchanged;
  final bool autoFocus;

  @override
  State<EditTextFeild> createState() => _EditTextFeildState();
}

class _EditTextFeildState extends State<EditTextFeild> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,

      validator: (value) {
        if (value!.isEmpty && widget.maxLines == 1) {
          return 'feild is required';
        } else {
          return null;
        }
      },
      autofocus: widget.autoFocus ,
      onChanged: widget.onchanged,
      cursorColor: kSecondaryColor,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,

        hintText: '',
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
