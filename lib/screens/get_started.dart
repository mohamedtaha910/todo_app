import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/start_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer(flex: 18),
          SizedBox(height: 130),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              'assets/picture/splash_one.svg',
              height: 400,
              // width: 340,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 40),
          SvgPicture.asset('assets/picture/Manage your tasks.svg'),
          SizedBox(height: 16),
          SvgPicture.asset('assets/picture/bromo.svg'),
          Spacer(),
          CustomButton(
            text: 'Get Started',
            marginHorizontal: 16,
            verticalPadding: 10,
            borderRadius: 25,
            textSize: 16,
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => StartPage()));
            },
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }
}
