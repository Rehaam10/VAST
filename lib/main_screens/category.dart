// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../providers/constants2.dart';
// import '../utilities/categ_list.dart';
// import '../widgets/appbar_widgets.dart';
// import '../widgets/categ_widgets.dart';
//
// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: textColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: textColor,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: const AppBarTitle(title: 'Categories'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: ListView.builder(
//           itemCount: glasses.length - 1,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.all(8).r,
//               child: SubcategModel(
//                 mainCategName: 'Glasses',
//                 subCategName: glasses[index + 1],
//                 assetName: 'assets/images/glasses/glass$index.jpg',
//                 subcategLabel: glasses[index + 1],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
