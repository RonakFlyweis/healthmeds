import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/healthcare/healthcare.dart';
import 'package:newhealthapp/pages/order_medicines/order_medicines.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:page_transition/page_transition.dart';

class DiscountGrid extends StatelessWidget {
  GlobalKey ?form =GlobalKey();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.only(right: fixPadding * 2.0, left: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Order Medicines
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: OrderMedicines()));
            },
            child: Container(
              width: ((width / 2.0) - fixPadding * 2.5),
              height: 150.0,
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 0.4, color: primaryColor.withOpacity(0.6)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset(
                      'assets/icons/icon_1.png',
                      width: 60.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    'Order Medicines',
                    style: blackHeadingStyle,
                  ),
                  Text(
                    'FLAT 15% OFF',
                    style: redDiscountStyle,
                  ),
                ],
              ),
            ),
          ),
          /// Healthcare Products
          InkWell(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>HealthCare(),
                  )
              );

            },
            child: Container(
              width: ((width / 2.0) - fixPadding * 2.5),
              height: 150.0,
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 0.4, color: primaryColor.withOpacity(0.6)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: Image.asset(
                      'assets/icons/icon_2.png',
                      width: 40.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Text(
                    'Healthcare Products',
                    style: blackHeadingStyle,
                  ),
                  Text(
                    'UPTO 60% OFF',
                    style: redDiscountStyle,
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
