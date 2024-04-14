import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rahoma_customers/main_screens/onboarding.dart';
import '../providers/constants2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(
        const OnBoarding(),
        transition: Transition.fadeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Vast",
              style: TextStyle(
                fontFamily: 'Explora',
                fontSize: 70.sp,
                color: scaffoldColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5.sp,
              ),
            ),
            SizedBox(height: 50.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoActivityIndicator(
                color: scaffoldColor,
                animating: true,
                radius: 10.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
