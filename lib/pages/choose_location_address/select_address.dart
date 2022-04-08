import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';

import 'add_address.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  int activeAddress = 0;
  String homeScreenAddress = '91, Opera Street';

  final addressList = [
    {
      'addressType': 'Home',
      'name': 'Allison Perry',
      'address': '91, Opera Street',
      'street': 'National Chowk',
      'city': 'Newyork 10001',
      'phone': '123456789',
      'deliveryDate': '26-Aug-2020'
    },
    {
      'addressType': 'Other',
      'name': 'Allison Perry',
      'address': '102, Atlantic Ave',
      'street': 'Brooklyn',
      'city': 'Newyork 11216',
      'phone': '123456789',
      'deliveryDate': '28-Aug-2020'
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
        titleSpacing: 0.0,
        title: Text('Select Address', style: appBarTitleStyle),
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  Navigator.pop(context, homeScreenAddress);
                },
                child: Container(
                  width: width - fixPadding * 4.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Save and Continue',
                    style: appBarTitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: AddAddress()));
            },
            child: Container(
              width: width,
              margin: EdgeInsets.all(fixPadding * 2.0),
              padding: EdgeInsets.all(fixPadding * 1.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.0, color: primaryColor),
              ),
              child: Text('Add New', style: primaryColorBigHeadingStyle),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: fixPadding * 2.0,
                right: fixPadding * 2.0,
                left: fixPadding * 2.0),
            child: Text('Deliver To', style: primaryColorHeadingStyle),
          ),
          getAddressList(),
        ],
      ),
    );
  }

  getAddressList() {
    double width = MediaQuery.of(context).size.width;
    return


      ColumnBuilder(
      itemCount: addressList.length,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      itemBuilder: (context, index) {
        final item = addressList[index];
        return InkWell(
          onTap: () {
            setState(() {
              homeScreenAddress = item['address']!;
              activeAddress = index;
            });
            print(homeScreenAddress);
          },
          child: Container(
            width: width,
            margin: EdgeInsets.all(fixPadding * 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                  width: 1.0,
                  color: (activeAddress == index)
                      ? primaryColor
                      : Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        (item['addressType'] == 'Home')
                            ? 'assets/icons/icon_9.png'
                            : (item['addressType'] == 'Work')
                                ? 'assets/icons/icon_10.png'
                                : 'assets/icons/icon_11.png',
                        width: 30.0,
                        fit: BoxFit.fitWidth,
                      ),
                      widthSpace,
                      Container(
                        width: width - (fixPadding * 8.0 + 30.0 + 10.0 + 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(item['addressType'].toString(),
                                    style: primaryColorHeadingStyle),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.5,
                                          color: (activeAddress == index)
                                              ? primaryColor
                                              : Colors.grey.shade300)),
                                  child: Container(
                                    width: 10.0,
                                    height: 10.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: (activeAddress == index)
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            heightSpace,
                            heightSpace,
                            Text(item['name'].toString(),
                                style: subHeadingStyle),
                            Text(item['address'].toString(),
                                style: subHeadingStyle),
                            Text(item['street'].toString(),
                                style: subHeadingStyle),
                            Text(item['city'].toString(),
                                style: subHeadingStyle),
                            Text(item['phone'].toString(),
                                style: subHeadingStyle),
                            heightSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete,
                                          size: 24.0, color: primaryColor),
                                      const SizedBox(width: 4.0),
                                      Text('Remove', style: subHeadingStyle)
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit,
                                          size: 24.0, color: primaryColor),
                                      const SizedBox(width: 4.0),
                                      Text('Edit', style: subHeadingStyle)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                (activeAddress == index)
                    ? Container(
                        width: width - fixPadding * 4.0,
                        padding: EdgeInsets.only(
                            right: fixPadding * 2.0,
                            left: fixPadding * 2.0,
                            top: fixPadding,
                            bottom: fixPadding),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(8.0)),
                          color: Colors.orange.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_12.png',
                                    width: 22.0, fit: BoxFit.fitWidth),
                                widthSpace,
                                Text('Delivery by', style: subHeadingBoldStyle),
                              ],
                            ),
                            Text(item['deliveryDate'].toString(),
                                style: primaryColorHeadingStyle),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
