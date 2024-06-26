// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import '../minor_screens/product_details.dart';
// import '../providers/constants2.dart';
// import '../providers/product_class.dart';
// import '../providers/wish_provider.dart';
//
// class SimilarItemsModel extends StatefulWidget {
//   final dynamic products;
//   const SimilarItemsModel({super.key, required this.products});
//
//   @override
//   State<SimilarItemsModel> createState() => _SimilarItemsModelState();
// }
//
// class _SimilarItemsModelState extends State<SimilarItemsModel> {
//   @override
//   Widget build(BuildContext context) {
//     var onSale = widget.products['discount'];
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsScreen(
//               proList: widget.products,
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(7).r,
//         child: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(5).r,
//               decoration: BoxDecoration(
//                 color: scaffoldColor,
//                 borderRadius: BorderRadius.circular(9).r,
//                 border: Border.all(
//                   color: Colors.white54,
//                   width: 1.w,
//                   style: BorderStyle.solid,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 9.h),
//                   Padding(
//                     padding: const EdgeInsets.all(5).r,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(7),
//                         topRight: Radius.circular(7),
//                       ).r,
//                       child: Container(
//                         constraints: const BoxConstraints(
//                           minHeight: 150,
//                           maxHeight: 200,
//                         ),
//                         child: CachedNetworkImage(
//                           filterQuality: FilterQuality.high,
//                           fit: BoxFit.fill,
//                           imageUrl: widget.products['proimages'][0],
//                           height: 195.h,
//                           placeholder: (context, url) => SpinKitThreeBounce(
//                             color: Colors.white60,
//                             size: 20.sp,
//                           ),
//                           errorWidget: (context, url, error) => Lottie.asset(
//                             "assets/json/imageError.json",
//                             filterQuality: FilterQuality.high,
//                             height: 45.h,
//                             width: 200.w,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${widget.products['proname']}",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontFamily: 'Dosis',
//                           letterSpacing: 1.sp,
//                           color: textColor,
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       SizedBox(height: 9.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Text(
//                             'EGP  ',
//                             style: TextStyle(
//                               fontFamily: 'Dosis',
//                               color: textColor,
//                               fontSize: 13.5.sp,
//                               letterSpacing: 0.5,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           onSale != 0
//                               ? Text(
//                                   ((1 - (widget.products['discount'] / 100)) *
//                                           widget.products['price'])
//                                       .toStringAsFixed(2),
//                                   style: TextStyle(
//                                     fontFamily: 'Dosis',
//                                     color: textColor,
//                                     fontSize: 12.sp,
//                                     letterSpacing: 1.sp,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 )
//                               : const Text(''),
//                           SizedBox(width: 4.w),
//                           Text(
//                             widget.products['price'].toStringAsFixed(2),
//                             style: onSale != 0
//                                 ? TextStyle(
//                                     fontFamily: 'Dosis',
//                                     color: Colors.grey,
//                                     fontSize: 8.sp,
//                                     letterSpacing: 0.5.sp,
//                                     decoration: TextDecoration.lineThrough,
//                                     fontWeight: FontWeight.w500,
//                                   )
//                                 : TextStyle(
//                                     fontFamily: 'Dosis',
//                                     color: textColor,
//                                     fontSize: 12.7.sp,
//                                     letterSpacing: 0.5.sp,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               var existingItemWishlist = context
//                                   .read<Wish>()
//                                   .getWishItems
//                                   .firstWhereOrNull((product) =>
//                                       product.documentId ==
//                                       widget.products['proid']);
//                               existingItemWishlist != null
//                                   ? context
//                                       .read<Wish>()
//                                       .removeThis(widget.products['proid'])
//                                   : context.read<Wish>().addWishItem(
//                                         Product(
//                                           documentId: widget.products['proid'],
//                                           name: widget.products['proname'],
//                                           price: onSale != 0
//                                               ? ((1 -
//                                                       (widget.products[
//                                                               'discount'] /
//                                                           100)) *
//                                                   widget.products['price'])
//                                               : widget.products['price'],
//                                           qty: 1,
//                                           qntty: widget.products['instock'],
//                                           imagesUrl:
//                                               widget.products.imagesList.first,
//                                           suppId: widget.products['sid'],
//                                         ),
//                                       );
//                             },
//                             icon: context
//                                         .watch<Wish>()
//                                         .getWishItems
//                                         .firstWhereOrNull((product) =>
//                                             product.documentId ==
//                                             widget.products['proid']) !=
//                                     null
//                                 ? Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                     size: 20.sp,
//                                   )
//                                 : Icon(
//                                     Icons.favorite_outline,
//                                     color: Colors.red,
//                                     size: 20.sp,
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             onSale != 0
//                 ? Positioned(
//                     top: 30,
//                     left: 0,
//                     child: Container(
//                       height: 25,
//                       width: 80,
//                       decoration: BoxDecoration(
//                         color: scaffoldColor,
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(10),
//                           bottomRight: Radius.circular(10),
//                         ).r,
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Save ${onSale.toString()} %',
//                           style: TextStyle(
//                             fontFamily: 'Dosis',
//                             color: textColor,
//                             letterSpacing: 1.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(
//                     color: Colors.transparent,
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
