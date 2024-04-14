// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:rahoma_customers/providers/constants2.dart';
//
// import '../minor_screens/subcateg_products.dart';
//
// class SubcategModel extends StatelessWidget {
//   final String mainCategName;
//   final String subCategName;
//   final String assetName;
//   final String subcategLabel;
//   const SubcategModel({
//     super.key,
//     required this.assetName,
//     required this.mainCategName,
//     required this.subCategName,
//     required this.subcategLabel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(
//           SubCategProducts(
//             maincategName: mainCategName,
//             subcategName: subCategName,
//           ),
//           transition: Transition.fadeIn,
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10).r,
//         ),
//         alignment: Alignment.center,
//         height: 70.h,
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: ListTile(
//           title: Text(
//             subcategLabel,
//             style: TextStyle(
//               fontFamily: 'Dosis',
//               fontSize: 13.sp,
//               fontWeight: FontWeight.bold,
//               letterSpacing: 1.sp,
//               color: scaffoldColor,
//             ),
//           ),
//           leading: Image.asset(
//             assetName,
//             width: 60.w,
//             height: 60.h,
//             fit: BoxFit.fill,
//           ),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             size: 15.sp,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategHeaderLabel extends StatelessWidget {
//   final String headerLabel;
//   const CategHeaderLabel({super.key, required this.headerLabel});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: Center(
//         child: Text(
//           headerLabel,
//           style: TextStyle(
//             fontSize: 40,
//             fontFamily: 'Explora',
//             fontWeight: FontWeight.bold,
//             letterSpacing: 4,
//             color: textColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
