import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
// import 'package:todo_app/constant.dart';
// import 'package:todo_app/constant.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconPadding,
    required this.backgroundColor,
    required this.height,
    this.headerHeight = 50,
  });
  final String title;
  final double height;
  final Widget icon;
  final Color iconColor;
  final double iconPadding;
  final Color backgroundColor;
  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// الخلفية
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
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

        /// العنوان
        Positioned(
          top: headerHeight,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(iconPadding),
                  decoration: BoxDecoration(
                    // color: kBackgroundColor.withAlpha(50),
                    color: iconColor,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(16),
                  ),
                  child: icon,
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        /// زرار الرجوع
        Positioned(
          top: 15,
          left: 15,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.only(left: 6, top: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  // color: kBackgroundColor.withAlpha(255),
                  color: Colors.white.withAlpha(240),
                  // color: Colors.white10,
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: const Color.fromARGB(255, 75, 202, 241),
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
