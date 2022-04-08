import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/profile/track_order.dart';
import 'package:page_transition/page_transition.dart';

class ActiveOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Active Orders', style: appBarTitleStyle),
      ),
      body: ListView(
        children: [
          heightSpace,
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: TrackOrder()));
            },
            child: Container(
              padding: EdgeInsets.all(fixPadding * 2.0),
              color: whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: whiteColor,
                    child: Image.asset(
                        'assets/deal_of_the_day/deal_of_the_day_2.png',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.fitHeight),
                  ),
                  widthSpace,
                  SizedBox(
                    width: width - (fixPadding * 4.0 + 100.0 + 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Garlic Pearls - Natural Way To Heathy Heart & Digestion - 100s',
                            style: primaryColorHeadingStyle),
                        heightSpace,
                        Text('Arriving: 29 Aug, 2020',
                            style: greyNormalTextStyle),
                        Container(
                          width: width - (fixPadding * 4.0 + 100.0 + 10.0),
                          margin: EdgeInsets.only(
                              top: fixPadding, bottom: fixPadding),
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Container(
                          width: width - (fixPadding * 4.0 + 100.0 + 10.0),
                          alignment: Alignment.centerRight,
                          child: Text('Track Order'.toUpperCase(),
                              style: primaryColorHeadingStyle),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
