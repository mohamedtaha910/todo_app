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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 46),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(25),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withAlpha(25),
                          width: 0.5,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black45,
                        size: 19,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/time.svg',
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 32),

                  SvgPicture.asset('assets/picture/Sign_Up_word.svg'),
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
                    marginHorizontal: 0,
                    borderRadius: 50,
                    verticalPadding: 10,
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
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      SvgPicture.asset('assets/icons/facebook.svg', height: 45),
                      SizedBox(width: 16),
                      SvgPicture.asset('assets/icons/google.svg', height: 45),
                      SizedBox(width: 16),
                      SvgPicture.asset('assets/icons/apple.svg', height: 45),
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
                          fontSize: 13,
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
                            fontSize: 13,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 24),
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
              marginHorizontal: 50,
              verticalPadding: 8,
              borderRadius: 25,
              color: Colors.red.withAlpha(50),
              textColor: Colors.red,
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
