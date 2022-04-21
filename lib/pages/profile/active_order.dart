import 'package:flutter/material.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/profile/track_order.dart';
import 'package:page_transition/page_transition.dart';

class ActiveOrder extends StatelessWidget {
  final activeOrder;

  const ActiveOrder({Key? key, required this.activeOrder}) : super(key: key);
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
                      child: TrackOrder(activeOrder: activeOrder)));
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
                    child: Image.network(
                        (imagebaseurl +
                            activeOrder["items"][0]["productId"]
                                ["productPictures"][0]["filename"]).toString(),
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
                        Text(activeOrder["items"][0]["productId"]["title"],
                            style: primaryColorHeadingStyle),
                        heightSpace,
                        Text('Arriving soon', style: greyNormalTextStyle),
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
