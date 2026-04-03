import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/components/start_text_feild.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/screens/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late UserCredential user;
  String? email;
  String? password;

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kBackgroundColor,

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black45,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/time.svg',
                      height: 310,
                    ),
                  ),
                  SizedBox(height: 32),
                  // SvgPicture.asset('assets/picture/Sign_Up_word.svg'),
                  // Text('Sign Up', style: TextStyle(fontSize: 24 , color: kSecondaryColor , fontWeight: FontWeight.bold) , ),

                  SizedBox(height: 32),
                  StartTextFeild(
                    hintText: 'Email',
                    icon: Icons.email,
                    onChanged: (value) => email = value,
                  ),
                  SizedBox(height: 24),
                  StartTextFeild(
                    hintText: 'Password',
                    icon: Icons.lock,
                    onChanged: (value) => password = value,
                  ),
                  SizedBox(height: 42),

                  CustomButton(
                    text: 'Sign Up',
                    marginHorizontal: 42,
                    borderRadius: 25,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(user: user),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showMessage(
                              context,
                              message: 'The password provided is too weak.',
                            );
                          }
                          if (e.code == 'email-already-in-use') {
                            showMessage(
                              context,
                              message:
                                  'The account already exists for that email.',
                            );
                          }
                        } catch (e) {
                          showMessage(
                            context,
                            message: 'Something went wrong $e',
                          );
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SvgPicture.asset('assets/icons/facebook.svg'),
                      SizedBox(width: 16),
                      SvgPicture.asset('assets/icons/google.svg'),
                      SizedBox(width: 16),
                      SvgPicture.asset('assets/icons/apple.svg'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LogInPage(),
                            ),
                          );
                        },
                        child: Text(
                          ' Log In',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMessage(BuildContext context, {required String message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red, size: 40),
            SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 32),
            CustomButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              text: 'Ok',
              marginHorizontal: 48,
              verticalPadding: 8,
              borderRadius: 25,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;

    user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
