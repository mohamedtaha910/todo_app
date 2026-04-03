import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class StartTextFeild extends StatefulWidget {
  const StartTextFeild({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onChanged, 
  });
  final String hintText;
  final IconData icon;
  final void Function(String)? onChanged;
  

  @override
  State<StartTextFeild> createState() => _StartTextFeildState();
}

class _StartTextFeildState extends State<StartTextFeild> {
  bool obscureText= true;
  @override
  Widget build(BuildContext context) {
    
    double borderRadius = 25;
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'feild is required';
        }else{
          return null;
        }
      },
      scrollPadding: EdgeInsets.symmetric(horizontal: 16),
      onChanged: widget.onChanged,
      obscureText: obscureText,

      cursorColor: kSecondaryColor,
      decoration: InputDecoration(
        suffix:  GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),

        fillColor: Colors.grey.withOpacity(0.1),
        filled: true,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: Colors.grey, size: 22),
            SizedBox(width: 8),
            Text(widget.hintText, style: TextStyle(color: Colors.grey)),
          ],
        ),

        // hintText: hintText,
        // hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
