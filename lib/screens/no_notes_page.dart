import 'package:flutter/material.dart';
import 'package:todo_app/constant.dart';

class NoNotesPage extends StatelessWidget {
  const NoNotesPage({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kSecondaryColor.withAlpha(50),
              ),
              child:Image.asset('assets/icons/no_tasks.png' ,height: 85,)
            ),
            SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
