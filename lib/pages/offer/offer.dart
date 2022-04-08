import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

// import 'package:healthmeds/pages/cart_payment/cart_payment.dart';
// import 'package:healthmeds/pages/offer/offer_detail.dart';
// import 'package:healthmeds/pages/search/search.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:page_transition/page_transition.dart';

import 'offer_detail.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  final offerList = [
    {
      'title':
          'Additional cashback upto \$5 on Amazon Pay | No coupon required',
      'image': 'assets/offer_icon/amazon_pay.png',
      'desc':
          'Pay via Amazon Pay and get Min \$1 to Max \$5 cashback, Valid on min. transaction of \$3.',
      'expiry': 'Expires On 31/08/2020'
    },
    {
      'title': '5% cashback on HSBC Credit card | No coupon code required',
      'image': 'assets/offer_icon/hsbc.jpg',
      'desc':
          '5% additional cashback up to \$3 on payment made via HSBC Credit card on a minimum transaction of \$10',
      'expiry': 'Expires On 30/08/2020'
    }
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Notifications', style: appBarTitleStyle),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Search()));
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text('1', style: TextStyle(color: whiteColor)),
              badgeColor: redColor,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Cart()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: offerList.length,
        itemBuilder: (context, index) {
          final item = offerList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: OfferDetail()));
            },
            child: Container(
              margin: EdgeInsets.only(
                top: (index == 0) ? fixPadding * 2.0 : fixPadding,
                right: fixPadding,
                left: fixPadding,
                bottom: (index == (offerList.length - 1)) ? fixPadding : 0.0,
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.2, color: primaryColor),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 1.5,
                    spreadRadius: 1.5,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.0,
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(8.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          color: whiteColor,
                          child: Image.asset(item['image'].toString(),
                              height: 60.0, fit: BoxFit.fitHeight),
                        ),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        Text(
                          '%',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: blackColor.withOpacity(0.6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width - (fixPadding * 2.0 + 100.0 + 0.4),
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'].toString(),
                            style: blackHeadingStyle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                        heightSpace,
                        Text(item['desc'].toString(),
                            style: greyNormalTextStyle),
                        heightSpace,
                        Text(item['expiry'].toString(),
                            style: greyNormalTextStyle),
                        heightSpace,
                        Container(
                          width: width -
                              (fixPadding * 2.0 +
                                  fixPadding * 3.0 +
                                  100.0 +
                                  0.4),
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        heightSpace,
                        heightSpace,
                        Container(
                          width: width -
                              (fixPadding * 2.0 +
                                  fixPadding * 3.0 +
                                  100.0 +
                                  0.4),
                          alignment: Alignment.centerRight,
                          child: Text('VIEW DETAILS',
                              style: primaryColorHeadingStyle),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
