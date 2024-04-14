import 'package:rahoma_customers/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rahoma_customers/main_screens/splash_screen.dart';
import 'package:rahoma_customers/providers/cart_provider.dart';
import 'package:rahoma_customers/providers/constants2.dart';
import 'package:rahoma_customers/providers/id_provider.dart';
import 'package:rahoma_customers/providers/sql_helper.dart';
import 'package:rahoma_customers/providers/wish_provider.dart';
import 'package:provider/provider.dart';
import 'package:rahoma_customers/splash.dart';
import 'auth/customer_login.dart';
import 'auth/customer_signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //SQLHelper.getDatabase;

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => Cart()),
        // ChangeNotifierProvider(create: (_) => Wish()),
        // ChangeNotifierProvider(create: (_) => IdProvider()),
        //ChangeNotifierProvider(create: (ctx) => ScreenIndexProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: scaffoldColor,
        statusBarColor: Colors.transparent,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          title: 'Vast',
          routes: {
            '/customer_signup': (context) => const CustomerRegister(),
            '/customer_login': (context) => const CustomerLogin(),
          },
        );
      },
    );
  }
}
