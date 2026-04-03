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
          height: 235,
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
          top: 20,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   padding: EdgeInsets.all(0),
                //   decoration: BoxDecoration(
                //     // color: kBackgroundColor.withAlpha(50),
                //     color: Colors.white10,
                //     shape: BoxShape.circle,
                //     // borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: Icon(Icons.person, color: Colors.white, size: 32),
                // ),
                // SizedBox(width: 12),
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

        /// زرار الرجوع
        // Positioned(
        //   top: 15,
        //   left: 15,
        //   child: SafeArea(
        //     child: GestureDetector(
        //       onTap: () => Navigator.pop(context),
        //       child: Container(
        //         padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        //         decoration: BoxDecoration(
        //           // color: kBackgroundColor.withAlpha(230),
        //           color: Colors.white10,
        //           // shape: BoxShape.circle,
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         child: Icon(
        //           Icons.arrow_back_ios,
        //           color: Colors.white,
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
                  color: const Color.fromARGB(255, 55, 203, 248),
                  size: 16,
                ),
              ),
            ),
          ),
        ),


        Positioned(
          top: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 53,
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
