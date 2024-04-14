import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../minor_screens/product_details.dart';
import '../providers/constants2.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({super.key, required this.products});

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('products')
      .doc(widget.products['proid'])
      .collection('reviews')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var onSale = widget.products['discount'];
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Colors.white70,
      onTap: () {
        // Get.to(
        //   ProductDetailsScreen(
        //     proList: widget.products,
        //   ),
        //   transition: Transition.fadeIn,
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 13, right: 13).r,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(9).r,
                    topRight: const Radius.circular(9).r,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 180.h,
                      maxHeight: 180.h,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.products['proimages'][0],
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      height: 200.h,
                      fadeInCurve: Curves.fastOutSlowIn,
                      placeholder: (context, url) => SpinKitThreeBounce(
                        color: Colors.white60,
                        size: 18.sp,
                      ),
                      errorWidget: (context, url, error) => Lottie.asset(
                        "assets/json/imageError.json",
                        filterQuality: FilterQuality.high,
                        height: 30.h,
                        width: 200.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "${widget.products['proname']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Dosis',
                        color: scaffoldColor,
                        fontSize: 15.sp,
                        letterSpacing: 1.5.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EGP ',
                          style: TextStyle(
                            fontFamily: 'Dosis',
                            color: scaffoldColor,
                            fontSize: 12.5.sp,
                            letterSpacing: 0.5.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.products['price'].toStringAsFixed(2),
                          style: onSale != 0
                              ? TextStyle(
                                  fontFamily: 'Dosis',
                                  color: scaffoldColor,
                                  fontSize: 9.sp,
                                  letterSpacing: 1.sp,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w500,
                                )
                              : TextStyle(
                                  fontFamily: 'Dosis',
                                  color: scaffoldColor,
                                  fontSize: 13.sp,
                                  letterSpacing: 1.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                        ),
                        // onSale != 0
                        //     ? Text(
                        //         ((1 - (widget.products['discount'] / 100)) *
                        //                 widget.products['price'])
                        //             .toStringAsFixed(2),
                        //         style: TextStyle(
                        //           fontFamily: 'Dosis',
                        //           color: scaffoldColor,
                        //           fontSize: 12.5.sp,
                        //           letterSpacing: 1.sp,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       )
                        //     : const Text(''),
                        // IconButton(
                        //   onPressed: () {
                        //     var existingItemWishlist = context
                        //         .read<Wish>()
                        //         .getWishItems
                        //         .firstWhereOrNull((product) =>
                        //             product.documentId ==
                        //             widget.products['proid']);
                        //     existingItemWishlist != null
                        //         ? context
                        //             .read<Wish>()
                        //             .removeThis(widget.products['proid'])
                        //         : context.read<Wish>().addWishItem(
                        //               Product(
                        //                 documentId: widget.products['proid'],
                        //                 name: widget.products['proname'],
                        //                 price: onSale != 0
                        //                     ? ((1 -
                        //                             (widget.products[
                        //                                     'discount'] /
                        //                                 100)) *
                        //                         widget.products['price'])
                        //                     : widget.products['price'],
                        //                 qty: 1,
                        //                 qntty: widget.products['instock'],
                        //                 imagesUrl:
                        //                     widget.products.imagesList.first,
                        //                 suppId: widget.products['sid'],
                        //               ),
                        //             );
                        //   },
                        //   icon: context
                        //               .watch<Wish>()
                        //               .getWishItems
                        //               .firstWhereOrNull((product) =>
                        //                   product.documentId ==
                        //                   widget.products['proid']) !=
                        //           null
                        //       ? const Icon(
                        //           Icons.favorite,
                        //           color: Colors.red,
                        //           size: 22,
                        //         )
                        //       : const Icon(
                        //           Icons.favorite_outline,
                        //           color: Colors.red,
                        //           size: 22,
                        //         ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            onSale != 0
                ? Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                        color: scaffoldColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Save ${onSale.toString()} %',
                          style: TextStyle(
                            color: textColor,
                            letterSpacing: 1,
                            fontSize: 12.5,
                            fontFamily: 'Dosis',
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                  ),
          ],
        ),
      ),
    );
  }
}
