import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:rahoma_customers/providers/auth_repo.dart';
import 'package:rahoma_customers/widgets/appbar_widgets.dart';
import 'package:rahoma_customers/widgets/snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../providers/constants2.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: textColor,
        appBar: AppBar(
          leading: AppBarBackButton(
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: textColor,
          title: const AppBarTitle(title: 'Forget Password'),
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8).r,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'to reset your password\n\nplease enter your email address\nand click on the button below',
                      style: TextStyle(
                        fontFamily: 'Dosis',
                        fontSize: 20.sp,
                        letterSpacing: 1.sp,
                        fontWeight: FontWeight.w200,
                        color: scaffoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 45.h),
                    TextFormField(
                      style:
                          TextStyle(fontFamily: 'Dosis', color: scaffoldColor),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        } else if (!value.isValidEmailAddress()) {
                          return 'invalid email';
                        } else if (value.isValidEmailAddress()) {
                          return null;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          fontFamily: 'Dosis',
                          color: scaffoldColor,
                          letterSpacing: 1.sp,
                        ),
                        hintText: 'enter your email',
                        hintStyle: TextStyle(
                          fontFamily: 'Dosis',
                          color: scaffoldColor,
                          letterSpacing: 2.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: scaffoldColor,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: scaffoldColor,
                            width: 2.5.w,
                          ),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                      ),
                    ),
                    SizedBox(height: 70.h),
                    AnimatedButton(
                      duration: 200,
                      shadowDegree: ShadowDegree.dark,
                      height: 40.h,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: scaffoldColor,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          AuthRepo.sendPasswordResetEmail(
                            emailController.text,
                          );
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              MyMessageHandler.showSnackBar(
                                _scaffoldKey,
                                'Check your Inbox',
                              );
                            },
                          );
                          Future.delayed(
                            const Duration(milliseconds: 2400),
                            () {
                              Get.back();
                            },
                          );
                        } else {
                          MyMessageHandler.showSnackBar(
                            _scaffoldKey,
                            'form not valid',
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'Send Reset Password Link',
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: textColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension EnailValidator on String {
  bool isValidEmailAddress() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
