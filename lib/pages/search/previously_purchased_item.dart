import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';

class PreviouslyPurchasedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          color: scaffoldBgColor,
          padding: EdgeInsets.all(fixPadding),
          child: Text(
            'Previously Purchased Items',
            style: subHeadingStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.all(fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width - 50.0,
                child: Text(
                  'Revital H - Daily Health Supplement - 30 Capsuls',
                  style: thickPrimaryColorHeadingStyle,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20.0, color: primaryColor),
            ],
          ),
        ),
      ],
    );
  }
}
