import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
// import 'package:healthmeds/constants/constants.dart';
// import 'package:healthmeds/pages/cart_payment/cart_payment.dart';
// import 'package:healthmeds/pages/search/search.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  getNotification() async {
    final sp = await SharedPreferences.getInstance();
    var token = sp.getString("AUTH_KEY");
    http.Response response = await http.get(
        Uri.parse('${ApiProvider.baseUrl}notifaction'),
        headers: {'Authorization': 'Bearer ${token}'});
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      return jsonDecode(response.body);
    } else {
      print("Error occured");
    }
  }

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
        body: FutureBuilder(
          future: getNotification(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data['getNotifaction'].length,
                itemBuilder: (context, index) {
                  final item = snapshot.data['getNotifaction'][index];
                  return Container(
                    margin: EdgeInsets.only(
                      top: fixPadding,
                      right: fixPadding,
                      left: fixPadding,
                      bottom: (index == (notificationList.length - 1))
                          ? fixPadding
                          : 0.0,
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
                                  (fixPadding * 2.0 +
                                      fixPadding * 4.0 +
                                      150.0 +
                                      0.4),
                              child: Text(
                                  'Hey, your order is successfully placed!',
                                  style: blackHeadingStyle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            // Container(
                            //   width: 150.0,
                            //   alignment: Alignment.centerRight,
                            //   child: Text(item['time'].toString(),
                            //       style: noteHintTextStyle),
                            // ),
                          ],
                        ),
                        heightSpace,
                        Text('ID: ${item["_id"]}', style: greyNormalTextStyle),
                      ],
                    ),
                  );
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container();
          },
        ));
  }
}
