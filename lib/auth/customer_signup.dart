import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rahoma_customers/auth/customer_login.dart';
import 'package:rahoma_customers/providers/auth_repo.dart';
import '../providers/constants2.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/snackbar.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String name;
  late String email;
  late String password;
  late String _uid;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;
  final spinkit = const SpinKitFadingCube(
    color: Colors.white70,
    size: 25,
  );

  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void signUp() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        await AuthRepo.signUpWithEmailAndPassword(email, password);
        AuthRepo.sendEmailVerification();

        _uid = AuthRepo.uid;

        AuthRepo.updateUserName(name);

        await customers.doc(_uid).set({
          'cid': _uid,
          'name': name,
          'email': email,
          'password': password,
        });
        _formKey.currentState!.reset();
        await Future.delayed(const Duration(microseconds: 100)).whenComplete(
          () => Navigator.pushReplacementNamed(
            context,
            '/customer_login',
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
        if (e.code == 'weak-password') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'The account already exists for that email.');
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    // const Color(0xff292C31),
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: textColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Padding(
                  padding: const EdgeInsets.only(left: 20).r,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontFamily: 'Limelight',
                        color: scaffoldColor,
                        fontSize: 40.sp,
                        letterSpacing: 2.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20).r,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "sign up now to browse our hot offers",
                      style: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        fontSize: 15.sp,
                        letterSpacing: 1.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 45.h),
                Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: scaffoldColor,
                      letterSpacing: 1.sp,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your username';
                      }
                      if (value.length > 17) {
                        return 'username must be less than 17 character';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                    maxLength: 17,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your Username',
                      hintStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
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
                          width: 3.w,
                        ),
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: scaffoldColor,
                      letterSpacing: 1.sp,
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email ';
                      } else if (value.isValidEmail() == false) {
                        return 'invalid email';
                      } else if (value.isValidEmail() == true) {
                        return null;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    //  controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
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
                          width: 3.w,
                        ),
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10).r,
                  child: TextFormField(
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: scaffoldColor,
                      letterSpacing: 2.sp,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your password';
                      }
                      if (value.contains("-")) {
                        return "can't include -";
                      }
                      if (value.length < 5) {
                        return 'weak password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    //controller: _passwordController,
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: scaffoldColor,
                        ),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        letterSpacing: 1.sp,
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
                          width: 3.w,
                        ),
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                  ),
                ),
                HaveAccount(
                  haveAccount: 'already have account? ',
                  actionLabel: 'Log In',
                  onPressed: () {
                    Get.to(
                      const CustomerLogin(),
                      transition: Transition.fadeIn,
                    );
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20).r,
                    child: AnimatedButton(
                      duration: 200,
                      shadowDegree: ShadowDegree.dark,
                      height: 40.h,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: scaffoldColor,
                      onPressed: () {
                        processing == true ? null : signUp();
                      },
                      child: processing == true
                          ? SpinKitFadingCube(
                              color: textColor,
                              size: 18.sp,
                            )
                          : Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Dosis',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
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
}
