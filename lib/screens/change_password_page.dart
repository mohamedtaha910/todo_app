import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todo_app/components/custom_button.dart';
import 'package:todo_app/components/custom_header.dart';
import 'package:todo_app/components/start_text_feild.dart';
import 'package:todo_app/constant.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String email = FirebaseAuth.instance.currentUser!.email!,
      oldPassword = '',
      newPassword = '',
      confirmPassword = '';
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,

        child: Form(
          autovalidateMode: autovalidateMode,
          key: formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),

            child: Column(
              children: [
                CustomHeader(
                  height: 180,
                  title: 'Reset Password',
                  icon: Image.asset('assets/icons/reset_password.png' , height: 30,),
                  iconColor: Colors.white10,
                  iconPadding: 8,
                  backgroundColor: kThirdColor,
                ),

                // SizedBox(height: 20),
                Transform.translate(
                  offset: Offset(0, -50),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Old Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        StartTextFeild(
                          hintText: 'old password',
                          icon: Icons.lock,
                          onChanged: (value) {
                            oldPassword = value;
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'New Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        StartTextFeild(
                          hintText: 'new password',
                          icon: Icons.lock,
                          onChanged: (value) {
                            newPassword = value;
                          },
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        StartTextFeild(
                          hintText: 'confirm password',
                          icon: Icons.lock,
                          onChanged: (value) {
                            confirmPassword = value;
                          },
                        ),
                        SizedBox(height: 32),
                        CustomButton(
                          color: kThirdColor,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              setState(() {
                                isLoading = true;
                              });
                              if (newPassword.length < 6) {
                                isLoading = false;
                                setState(() {});
                                showMessage(
                                  context,
                                  message:
                                      'Password must be at least 6 characters',
                                  icon: Icons.error,
                                  color: Colors.red,
                                );
                              } else if (newPassword != confirmPassword) {
                                isLoading = false;
                                setState(() {});
                                showMessage(
                                  context,
                                  message: 'Passwords do not match',
                                  icon: Icons.error,
                                  color: Colors.red,
                                );
                              } else {
                                // // ================== windows =====================================
                                // await Future.delayed(
                                //   Duration(seconds: 2),
                                //   () {},
                                // );

                                // isLoading = false;
                                // setState(() {});
                                // showMessage(
                                //   context,
                                //   message: 'Password change successfully',
                                //   icon: Icons.check,
                                //   color: Colors.green,
                                // );
                                // =================== emulator =====================================

                                print('Password changed successfullyy');

                                bool result = await updatePassword(
                                  email: email,
                                  oldPassword: oldPassword,
                                  newPassword: newPassword,
                                );
                                isLoading = false;
                                setState(() {});

                                if (result) {
                                  showMessage(
                                    context,
                                    message: 'Password changed successfully',
                                    icon: Icons.check,
                                    color: Colors.green,
                                  );
                                }else{
                                  showMessage(
                                    context,
                                    message: 'Something went wrong',
                                    icon: Icons.error,
                                    color: Colors.red,
                                  );
                                }
                                // =====================================================================
                              }
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                          text: 'Change Password',
                          marginHorizontal: 0,
                          borderRadius: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMessage(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color color,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(color == Colors.green ? 16 : 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: color == Colors.green
                    ? Colors.green.withAlpha(50)
                    : Colors.red.withAlpha(50),
              ),
              child: Icon(icon, color: color, size: 40),
            ),
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
              color: kThirdColor,
              onTap: () {
                Navigator.of(context).pop();
                color == Colors.green ? Navigator.of(context).pop() : null;
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

  Future<bool> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    User user = FirebaseAuth.instance.currentUser!;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        showMessage(
          context,
          message: 'Incorrect old password',
          icon: Icons.error,
          color: Colors.red,
        );
        return false;
      }
      return false;
    } catch (e) {
      showMessage(
        context,
        message: 'Error: $e',
        icon: Icons.error,
        color: Colors.red,
      );
      return false;
    }
  }
}
