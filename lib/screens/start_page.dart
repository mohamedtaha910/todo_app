import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/log_in_page.dart';
import 'package:todo_app/screens/sign_up_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black45),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(flex: 22),
          SvgPicture.asset(
            'assets/picture/splash_two.svg',
          ),
          // SizedBox(height: 33),
          Spacer(flex: 16),
          SvgPicture.asset('assets/picture/Start Manage Your Task With Mtodo.svg'),
          // SizedBox(height: 24),
         
          Spacer(flex: 16),
          CustomButton(text: 'Sign Up' ,marginHorizontal: 42, borderRadius: 25,onTap: () {

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
          }, ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ' , style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
            SizedBox(height: 32),
        ],
      ),
    );
  }
}