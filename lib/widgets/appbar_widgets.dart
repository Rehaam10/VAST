import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../providers/constants2.dart';

class AppBarBackButton extends StatelessWidget {
  final Function() onPressed;
  const AppBarBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        PixelArtIcons.arrow_left,
        color: scaffoldColor,
        size: 15.5.sp,
      ),
      onPressed: onPressed,
    );
  }
}

class BlackBackButton extends StatelessWidget {
  const BlackBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: scaffoldColor,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: scaffoldColor,
        fontSize: 20,
        letterSpacing: 1.5,
        fontFamily: 'Dosis',
      ),
    );
  }
}
