import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/home/prevoius_order_row.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:page_transition/page_transition.dart';

import '../../api/api_provider.dart';
import 'order_via_prescription.dart';

class OrderMedicines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Order Medicines', style: appBarTitleStyle),
        actions: [
          IconButton(
            icon: Badge(
              badgeContent: Text('1', style: TextStyle(color: whiteColor)),
              badgeColor: redColor,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
              final data = await ApiProvider.getcartItems();
              final cartList;
              if (data["data"].length == 0) {
                cartList = [];
              } else {
                cartList = data["data"][0]["cartItems"];
              }
              EasyLoading.dismiss();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Cart(cartList: cartList)));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: width,
            height: 280.0,
            color: whiteColor,
            child: Stack(
              children: [
                Positioned(
                  top: 0.0,
                  child: Container(
                    width: width,
                    height: 260.0,
                    color: primaryColor,
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          strokeWidth: 0.4,
                          padding: EdgeInsets.all(fixPadding),
                          color: whiteColor,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getDescTile(
                                    Icon(Icons.local_offer,
                                        color: whiteColor, size: 15.0),
                                    'Flat',
                                    '15% Off'),
                                getDescTile(
                                    Icon(Icons.security,
                                        color: whiteColor, size: 15.0),
                                    '1 Lakh+',
                                    'Products'),
                                getDescTile(
                                    Icon(Icons.flip_to_back,
                                        color: whiteColor, size: 15.0),
                                    'Easy',
                                    'Returns'),
                              ],
                            ),
                          ),
                        ),
                        heightSpace,
                        heightSpace,
                        Text('Search medicines/healthcare products',
                            style: thickWhiteTextStyle),
                        heightSpace,
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: Search()));
                          },
                          child: Container(
                            width: width - fixPadding * 2.0,
                            padding: EdgeInsets.all(fixPadding * 0.9),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: whiteColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.search,
                                    color: primaryColor, size: 18.0),
                                widthSpace,
                                Text(
                                  'Search medicines/healthcare products',
                                  style: searchTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 39.0,
                          height: 39.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(19.5),
                            border: Border.all(width: 1.0, color: whiteColor),
                          ),
                          child: Text(
                            'OR',
                            style: primaryColorHeadingStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Previous Order Row Start
          PreviousOrder(),
          // Previous Order Row Ends
          /// Order via Prescription Row Start
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: OrderViaPrescription()));
            },
            child: Container(
              margin: EdgeInsets.all(fixPadding * 2.0),
              padding: EdgeInsets.all(fixPadding * 2.0),
              width: width - fixPadding * 4.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 0.4, color: primaryColor.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30.0,
                        height: 30.0,
                        child: Image.asset(
                          'assets/icons/icon_5.png',
                          width: 30.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      widthSpace,
                      Text(
                        'Order via Prescription',
                        style: primaryColorBigHeadingStyle,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 20.0, color: primaryColor),
                ],
              ),
            ),
          ),
          // Order via Prescription Row End
        ],
      ),
    );
  }

  getDescTile(Icon icon, String title1, String title2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 0.7, color: whiteColor),
          ),
          child: icon,
        ),
        widthSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: thickWhiteTextStyle,
            ),
            Text(
              title2,
              style: thickWhiteTextStyle,
            )
          ],
        ),
      ],
    );
  }
}
