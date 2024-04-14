import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rahoma_customers/main_screens/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import '../auth/customer_login.dart';
import '../providers/cart_provider.dart';
import '../providers/id_provider.dart';
import '../providers/wish_provider.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<String> documentId;
  // late String docId = context.read<IdProvider>().getData;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<Cart>().loadCartItemsProvider();
  //   //context.read<Wish>().loadWishItemsProvider();
  //   context.read<IdProvider>().getDocId();
  //   documentId = _prefs.then((SharedPreferences prefs) {
  //     return prefs.getString('customerid') ?? '';
  //   }).then((String value) {
  //     setState(() {
  //       docId = value;
  //     });
  //     return docId;
  //   });
  // }

  final onBoardingController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 80.0,
        ),
        child: PageView(
          controller: onBoardingController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            buildPage(
              'Hello everyone',
              'Welcome to VAST..',
            ),
            buildPage(
              'Online Shopping',
              'where you can buy many different things..',
            ),
            buildPage(
              'Welcome to VAST..',
              'where you can try online products, services and glasses..',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 10,
                  right: 10,
                ),
                child: defaultElevatedButton(
                  function: () {
                    Navigator.pushReplacement(context, const CustomerLogin() as Route<Object?>);
                    // Get.off(
                    //   docId != ''
                    //       ? const CategoryScreen()
                    //       : const CustomerLogin(),
                    // );
                  },
                  txt: 'Get Started',
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      onBoardingController.jumpToPage(2);
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dosis',
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                        activeDotColor: Colors.black,
                      ),
                      controller: onBoardingController,
                      count: 3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onBoardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Dosis',
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
