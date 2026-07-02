import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/custom_button.dart';
// import 'package:todo_app/components/custom_text_feild.dart';
import 'package:todo_app/components/start_text_feild.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/screens/home_page.dart';
import 'package:todo_app/screens/sign_up_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 20),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/time2.svg',
                      height: 239,
                    ),
                  ),

                  SizedBox(height: 32),
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  StartTextFeild(
                    hintText: 'Email',
                    icon: Icons.email,
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 24),
                  StartTextFeild(
                    hintText: 'Password',
                    icon: Icons.lock,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  // Spacer(flex: 2),
                  SizedBox(height: 42),
                  CustomButton(
                    text: 'Log In',
                    marginHorizontal: 0,
                    verticalPadding: 10,
                    borderRadius: 50,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(user: user),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            showMessage(
                              context,
                              message: 'email address is not valid.',
                            );
                          } else if (e.code == 'user-not-found') {
                            showMessage(
                              context,
                              message: 'No user for the given email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showMessage(
                              context,
                              message: 'Wrong password provided for that user.',
                            );
                          } else if (e.code == 'unknown-error') {
                            showMessage(
                              context,
                              message: 'The email or password is incorrect',
                            );
                          } else {
                            showMessage(
                              context,
                              message: '${e.code} There was an error ',
                            );
                          }
                        } catch (e) {
                          showMessage(
                            context,
                            message: 'There was an error: $e',
                          );
                        } finally {
                          // This ensures isLoading is set to false regardless of success or error
                          isLoading = false;
                          setState(() {});
                        }
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
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
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          ' Register now',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 16),
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
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(50),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error, color: Colors.red, size: 40),
            ),
            SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26),
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
