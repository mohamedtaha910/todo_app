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
          Spacer(flex: 18),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/picture/splash_one.svg',
              height: 440,
              width: 380,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 20),
          SvgPicture.asset('assets/picture/Manage your tasks.svg'),
          SizedBox(height: 16),
          SvgPicture.asset('assets/picture/bromo.svg'),
          Spacer(flex: 10),
          CustomButton(text: 'Get Started' ,marginHorizontal: 42, borderRadius: 25,onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => StartPage()));
          }, ),
          SizedBox(height: 42),
        ],
      ),
    );
  }
}
