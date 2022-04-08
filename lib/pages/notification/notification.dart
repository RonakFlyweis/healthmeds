import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
// import 'package:healthmeds/constants/constants.dart';
// import 'package:healthmeds/pages/cart_payment/cart_payment.dart';
// import 'package:healthmeds/pages/search/search.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:page_transition/page_transition.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final notificationList = [
    {
      'title': 'Hey, your cart_payment is waiting!',
      'desc':
      'But your health can\'t. Complete your purchase now & get FLAT 15% OFF on medicines + Amazon Pay cashback up to \$5. *T&C',
      'time': '16th Aug, 06:15 PM'
    },
    {
      'title': 'Gentle Reminder - Stay Home, Stay Safe',
      'desc':
      'Order medicines now & get FLAT 20% OFF on your order. Check out our app for other exciting offers! Order now & get safe home delivery. *T&C',
      'time': '15th Aug, 10:04 AM'
    }
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text('Notifications', style: appBarTitleStyle),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft, child: Search()));
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
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft, child: Cart()
              //     ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          final item = notificationList[index];
          return Container(
            margin: EdgeInsets.only(
              top: fixPadding,
              right: fixPadding,
              left: fixPadding,
              bottom:
              (index == (notificationList.length - 1)) ? fixPadding : 0.0,
            ),
            padding: EdgeInsets.all(fixPadding * 2.0),
            decoration: BoxDecoration(
              color: whiteColor,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width -
                          (fixPadding * 2.0 + fixPadding * 4.0 + 150.0 + 0.4),
                      child: Text(item['title'].toString(),
                          style: blackHeadingStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      width: 150.0,
                      alignment: Alignment.centerRight,
                      child: Text(item['time'].toString(), style: noteHintTextStyle),
                    ),
                  ],
                ),
                heightSpace,
                Text(item['desc'].toString(), style: greyNormalTextStyle),
              ],
            ),
          );
        },
      ),
    );
  }
}
