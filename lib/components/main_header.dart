import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/calender_page.dart';
import 'package:todo_app/screens/profile_page.dart';

class MainHeader extends StatefulWidget {
  const MainHeader({super.key, required this.date});
  final DateTime date;

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMMM dd, yyyy ').format(widget.date);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// Background Container
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          height: 200,
          width: double.infinity,
          // color: kSecondaryColor,
        ),

        /// Ellipse 1
        Positioned(
          top: 55,
          left: 0,
          child: SvgPicture.asset('assets/picture/Ellipse 1.svg'),
        ),

        /// Ellipse 2
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset('assets/picture/Ellipse 2.svg'),
        ),

        /// Header Title
        Positioned(
          top: 80,
          right: 0,
          left: 0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('assets/picture/Header Title.svg')],
          ),
        ),

        /// Date
        Positioned(
          top: 22,
          // right: MediaQuery.of(context).size.width / 2 - 55,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),

        /// Profile
        Positioned(
          top: 10,
          right: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                  // builder: (context) => CalendarPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha(100),
              ),
              child: Image.asset('assets/icons/user.png', height: 26),
            ),
          ),
        ),

        /// Calendar
        Positioned(
          top: 10,
          left: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withAlpha(55),
              ),
              child: Image.asset('assets/icons/calendar6.png', height: 28),
            ),
          ),
        ),
      ],
    );
  }
}
