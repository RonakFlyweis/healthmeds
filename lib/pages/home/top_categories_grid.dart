import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/products_list/product_list.dart';
import 'package:page_transition/page_transition.dart';

class TopCategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: whiteColor,
      padding: EdgeInsets.only(top: fixPadding * 2.0, bottom: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: fixPadding * 2.5),
            child: Text(
              'Top Categories',
              style: blackHeadingStyle,
            ),
          ),
          heightSpace,
          getItemGrid(width, context),
        ],
      ),
    );
  }

  getItemGrid(double width, BuildContext context) {
    return Container(
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductList()));
                  },
                  child: SizedBox(
                    width: ((width / 2.0) - fixPadding * 2.5),
                    child: Image.asset(
                        'assets/top_categories/top_category_1.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductList()));
                  },
                  child: Container(
                    width: ((width / 2.0) - fixPadding * 2.5),
                    child: Image.asset(
                        'assets/top_categories/top_category_2.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ],
            ),
          ),
          heightSpace,
          Padding(
            padding: EdgeInsets.only(
                right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductList()));
                  },
                  child: Container(
                    width: ((width / 2.0) - fixPadding * 2.5),
                    child: Image.asset(
                        'assets/top_categories/top_category_3.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductList()));
                  },
                  child: Container(
                    width: ((width / 2.0) - fixPadding * 2.5),
                    child: Image.asset(
                        'assets/top_categories/top_category_4.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
