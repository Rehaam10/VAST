import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rahoma_customers/auth/customer_signup.dart';
import 'package:rahoma_customers/auth/forgot_password.dart';
import 'package:rahoma_customers/providers/auth_repo.dart';
import 'package:rahoma_customers/providers/id_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/constants2.dart';
import '../widgets/auth_widgets.dart';
import '../widgets/snackbar.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var doc = await customers.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // setUserId(User user) {
  //   context.read<IdProvider>().setCustomerId(user);
  // }

  bool docExists = false;

  late String email;
  late String password;
  bool processing = false;
  bool sendEmailVerification = false;
  final spinkit = SpinKitFadingCube(
    color: scaffoldColor,
    size: 25,
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;

  void navigate() {
    Get.offNamed('/customer_home');
  }

  void logIn() async {
    setState(() {
      processing = true;
    });
    Future.delayed(const Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        try {
          await AuthRepo.signInWithEmailAndPassword(email, password);
          await AuthRepo.reloadUserData();
          if (await AuthRepo.checkEmailVerification()) {
            _formKey.currentState!.reset();
            User user = FirebaseAuth.instance.currentUser!;
            //setUserId(user);
            navigate();
          } else {
            setState(() {
              processing = false;
              sendEmailVerification = true;
            });
            MyMessageHandler.showSnackBar(
                _scaffoldKey, 'please check your inbox');
          }
        } on FirebaseAuthException catch (e) {
          setState(() {
            processing = false;
          });
          MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
        }
      } else {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, 'please fill all fields');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: textColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Padding(
                  padding: const EdgeInsets.only(left: 20).r,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontFamily: 'Limelight',
                        letterSpacing: 2.sp,
                        color: scaffoldColor,
                        fontSize: 38.sp,
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
                      "log in now to browse our hot offers",
                      style: TextStyle(
                        fontFamily: 'Dosis',
                        letterSpacing: 1.sp,
                        color: scaffoldColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                sendEmailVerification == true
                    ? Center(
                        child: Container(
                          height: 32.h,
                          width: 190.w,
                          decoration: BoxDecoration(
                            color: scaffoldColor,
                            borderRadius: BorderRadius.circular(7).r,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              MyMessageHandler.showSnackBar(
                                _scaffoldKey,
                                'Sending email verification . . .',
                              );
                              try {
                                await FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                              Future.delayed(const Duration(seconds: 3))
                                  .whenComplete(() {
                                setState(() {
                                  sendEmailVerification == false;
                                });
                                MyMessageHandler.showSnackBar(
                                  _scaffoldKey,
                                  'Check your email now',
                                );
                              });
                            },
                            child: Center(
                              child: Text(
                                'Resend Email Verification',
                                style: TextStyle(
                                  fontFamily: 'Dosis',
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.sp,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(height: 32.h),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ).r,
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
                    cursorColor: scaffoldColor,
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
                          borderRadius: BorderRadius.circular(10).r),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: scaffoldColor, width: 1.w),
                          borderRadius: BorderRadius.circular(10).r),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: scaffoldColor, width: 3.w),
                          borderRadius: BorderRadius.circular(10).r),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ).r,
                  child: TextFormField(
                    cursorColor: scaffoldColor,
                    style: TextStyle(
                      fontFamily: 'Dosis',
                      color: scaffoldColor,
                      letterSpacing: 1.sp,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    //   controller: _passwordController,
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
                        letterSpacing: 1,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: scaffoldColor, width: 1.w),
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: scaffoldColor, width: 3.w),
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20).r,
                    child: AnimatedButton(
                      duration: 10,
                      enabled: true,
                      shadowDegree: ShadowDegree.dark,
                      height: 40.h,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: scaffoldColor,
                      onPressed: () {
                        processing == true ? null : logIn();
                      },
                      child: processing == true
                          ? SpinKitFadingCube(
                              color: textColor,
                              size: 18.sp,
                            )
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Dosis',
                                letterSpacing: 1.sp,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Padding(
                  padding: const EdgeInsets.all(7).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(
                            const ForgotPassword(),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: scaffoldColor,
                            fontSize: 17.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      HaveAccount(
                        haveAccount: 'Don\'t Have Account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Get.to(
                            const CustomerRegister(),
                            transition: Transition.fadeIn,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    top: 15,
                  ).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          var whatsapp = "+201065263402";
                          final Uri url = Uri.parse(
                              "whatsapp://send?phone=$whatsapp&text=ازيك يا رهومه");
                          Future<void> launch() async {
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw 'Could not launch $url';
                            }
                          }

                          launch();
                        },
                        child: Icon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                          size: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri url =
                              Uri.parse("https://www.facebook.com/roo.ma.543/");
                          Future<void> launch() async {
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalNonBrowserApplication,
                            )) {
                              throw 'Could not launch $url';
                            }
                          }

                          launch();
                        },
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                          size: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri url = Uri.parse(
                              "https://www.instagram.com/rahhoma_10/");
                          Future<void> launch() async {
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalNonBrowserApplication,
                            )) {
                              throw 'Could not launch $url';
                            }
                          }

                          launch();
                        },
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          color: Colors.deepOrange,
                          size: 18.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final Uri url = Uri.parse(
                              "https://www.linkedin.com/in/reham-abdelhameed-85bb3921b/");
                          Future<void> launch() async {
                            if (!await launchUrl(
                              url,
                              mode: LaunchMode.externalNonBrowserApplication,
                            )) {
                              throw 'Could not launch $url';
                            }
                          }

                          launch();
                        },
                        child: Icon(
                          FontAwesomeIcons.linkedinIn,
                          color: Colors.blue[300]!,
                          size: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                Center(
                  child: Text(
                    "Vast",
                    style: TextStyle(
                      fontFamily: 'CinzelDecorative',
                      color: scaffoldColor,
                      letterSpacing: 3.sp,
                      fontSize: 16.sp,
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
