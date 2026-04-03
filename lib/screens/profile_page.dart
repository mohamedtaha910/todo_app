import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components/horizintal_line.dart';
import 'package:todo_app/components/profile_row.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/Profile_header.dart';
import 'package:todo_app/screens/calender_page.dart';
import 'package:todo_app/screens/change_password_page.dart';
import 'package:todo_app/screens/splash_page.dart';
import 'package:todo_app/screens/statistics_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   surfaceTintColor: Colors.transparent,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black54),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   title: Text(
      //     'Profile',
      //     style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ProfileHeader(),

            Transform.translate(
              offset: Offset(0, -45),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'General',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      // height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.black.withAlpha(23),
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileRow(
                            title: 'Calendar',
                            icon: Icons.calendar_month_rounded,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CalendarPage(),
                                ),
                              );
                            },
                          ),
                          HorizintalLine(),

                          ProfileRow(
                            title: 'Settings',
                            icon: Icons.settings,
                            onTap: () {},
                          ),

                          HorizintalLine(),

                          ProfileRow(
                            title: 'Statistics',
                            icon: Icons.bar_chart_rounded,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StatisticsPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                    Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      // height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.black.withAlpha(23),
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileRow(
                            title: 'Change Password',
                            icon: Icons.lock,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordPage(),
                                ),
                              );
                            },
                          ),
                          // const SizedBox(height: 8),
                          HorizintalLine(),

                          ProfileRow(
                            title: 'Logout',
                            icon: Icons.logout,
                            onTap: () {
                              signOut(context);
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signOut(context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          'Are you sure you want to Logout?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              backgroundColor: Colors.green.withAlpha(50),
              foregroundColor: Colors.black,
            ),
            child: Text("Cancel"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 213, 59, 47),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);

              await FirebaseAuth.instance.signOut();


              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashPage()),
                (route) => false,
              );
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
