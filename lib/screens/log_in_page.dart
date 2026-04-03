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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),

              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/time2.svg',
                    height: 280,
                  ),

                  SizedBox(height: 32),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SvgPicture.asset(
                  //       'assets/picture/Hello again! welcome back.svg',
                  //       height: 55,
                  //       width: 300,
                  //     ),
                  //   ],
                  // ),
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
                    marginHorizontal: 42,
                    borderRadius: 25,
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
                              message:
                                  'No user for the given email.',
                            );
                          }else if(e.code == 'wrong-password'){
                            showMessage(
                              context,
                              message: 'Wrong password provided for that user.',
                            );
                          }
                           else if (e.code == 'unknown-error') {
                            showMessage(
                              context,
                              message: 'The email or password is incorrect',
                            );
                          } else {
                            showMessage(
                              context,
                              message:
                                  '${e.code} There was an error ',
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
                  Text(
                    'Or continue with',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
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
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          ' Register now',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
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
              child: Icon(Icons.error, color: Colors.red, size: 40)),
            SizedBox(height: 24),
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
