import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/order_medicines/previously_bought_item.dart';
import 'package:page_transition/page_transition.dart';

class PreviousOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: PreviouslyBoughtItem()));
            },
            child: Container(
              width: ((width / 2.0) - fixPadding * 2.5),
              height: 63.0,
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 0.4, color: primaryColor.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: Image.asset(
                      'assets/icons/icon_3.png',
                      width: 30.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  widthSpace,
                  SizedBox(
                    width: ((width / 2.0) - fixPadding * 2.58 - 60.0),
                    child: Text(
                      '1 Previously Bought Item',
                      style: blackHeadingStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: PreviouslyBoughtItem()));
            },
            child: Container(
              width: ((width / 2.0) - fixPadding * 2.5),
              height: 63.0,
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 0.4, color: primaryColor.withOpacity(0.6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: Image.asset(
                      'assets/icons/icon_4.png',
                      width: 30.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  widthSpace,
                  SizedBox(
                    width: ((width / 2.0) - fixPadding * 2.58 - 60.0),
                    child: Text(
                      '1 Past Order',
                      style: blackHeadingStyle,
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
