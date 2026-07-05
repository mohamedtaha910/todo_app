import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/constant.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// الخلفية
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
        ),

        /// Ellipse 1
        Positioned(
          top: 100,
          left: 0,
          child: SvgPicture.asset('assets/picture/Ellipse 1.svg'),
        ),

        /// Ellipse 2
        Positioned(
          top: 0,
          right: 0,
          child: SvgPicture.asset('assets/picture/Ellipse 2.svg', height: 140),
        ),

        /// العنوان
        Positioned(
          top: 18,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 18,
          left: 16,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  // color: kBackgroundColor.withAlpha(255),
                  color: Colors.white.withAlpha(240),
                  // color: Colors.white10,
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black54,
                  size: 26,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 51,
                  backgroundColor: Colors.grey.shade200,
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/icons/user2.png'),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF9eacbc),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
