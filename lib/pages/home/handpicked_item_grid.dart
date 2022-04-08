import 'package:flutter/material.dart';
// import 'package:healthmeds/constants/constants.dart';
// import 'package:healthmeds/pages/product/product.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/product/product.dart';
import 'package:page_transition/page_transition.dart';

class HandpickedItemGrid extends StatefulWidget {
  @override
  _HandpickedItemGridState createState() => _HandpickedItemGridState();
}

class _HandpickedItemGridState extends State<HandpickedItemGrid> {
  final handpickedItemList = [
    {
      'itemId': 1,
      'image': 'assets/handpicked_item/handpicked_item_1.png',
      'name':
      'Liveasy Wellness Multivitamin Multimineral - Added Ginseng, Grapeseed & Ginkgo Biloba Extracts - Strong Immunity- 60 Tablets',
      'qty': '60 Tablet(s) in Bottle',
      'oldPrice': '12',
      'price': '6',
      'offer': '50% OFF',
      'companyName': 'LivEasy',
      'imageList': [
        'assets/handpicked_item/handpicked_item_1.png',
        'assets/handpicked_item/handpicked_item_1.png',
        'assets/handpicked_item/handpicked_item_1.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Zeon Lifesciences Limited',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 2,
      'image': 'assets/handpicked_item/handpicked_item_2.png',
      'name': 'Liveasy Women Multi-vitamin Tablets Bottle Of 60',
      'qty': '60 Tablet(s) in Bottle',
      'oldPrice': '13',
      'price': '8',
      'offer': '30% OFF',
      'companyName': 'LivEasy',
      'imageList': [
        'assets/handpicked_item/handpicked_item_2.png',
        'assets/handpicked_item/handpicked_item_2.png',
        'assets/handpicked_item/handpicked_item_2.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Zeon Lifesciences Limited',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 3,
      'image': 'assets/handpicked_item/handpicked_item_3.png',
      'name':
      'Liveasy Wellness Calcium, Magnesium, Vitamin D3 & Zinc - Strong Bones & Dental Health - 60 Tablets',
      'qty': '60 Tablet(s) in Bottle',
      'oldPrice': '15',
      'price': '7',
      'offer': '55% OFF',
      'companyName': 'LivEasy',
      'imageList': [
        'assets/handpicked_item/handpicked_item_3.png',
        'assets/handpicked_item/handpicked_item_3.png',
        'assets/handpicked_item/handpicked_item_3.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Zeon Lifesciences Limited',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 4,
      'image': 'assets/handpicked_item/handpicked_item_4.png',
      'name':
      'Everherb Moringa (drumsticks) 500mg - 2x Potency - Natural Multivitamin - Immunity Booster - 60 Capsules',
      'qty': '60 Capsule(s) in Bottle',
      'oldPrice': '6',
      'price': '4',
      'offer': '20% OFF',
      'companyName': 'EverHerb',
      'imageList': [
        'assets/handpicked_item/handpicked_item_4.png',
        'assets/handpicked_item/handpicked_item_4.png',
        'assets/handpicked_item/handpicked_item_4.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Bacfo Pharmaceuticals (india) Ltd',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 5,
      'image': 'assets/handpicked_item/handpicked_item_5.png',
      'name': 'Revital H - Daily Health Supplement - 30 Capsules',
      'qty': '30 Capsules(s) in Bottle',
      'oldPrice': '5',
      'price': '4',
      'offer': '10% OFF',
      'companyName': 'REVITAL',
      'imageList': [
        'assets/handpicked_item/handpicked_item_5.png',
        'assets/handpicked_item/handpicked_item_5.png',
        'assets/handpicked_item/handpicked_item_5.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['10 NO\'s', '30 NO\'s', '60 NO\'s'],
      'selectedPackSize': '10 NO\'s',
      'manufacturer': 'Sun Pharma',
      'countryOfOrigin': 'India'
    }
  ];

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
              'Handpicked Items for You',
              style: blackHeadingStyle,
            ),
          ),
          heightSpace,
          getItemGrid(),
        ],
      ),
    );
  }

  getItemGrid() {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 275.0,
      child: ListView.builder(
        itemCount: handpickedItemList.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = handpickedItemList[index];
          return InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft,
              //         child: Product(productDetails: item)));
            },
            child: Container(
              width: 170.0,
              margin: (index == (handpickedItemList.length - 1))
                  ? const EdgeInsets.only(left: 20.0, right: 20.0)
                  : const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: '${item['image']}',
                        child: Container(
                          width: 170.0,
                          height: 170.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 0.6,
                                color: primaryColor.withOpacity(0.6)),
                          ),
                          child: Container(
                            width: 130.0,
                            height: 130.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(item['image'].toString()),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child:
                          Text(item['offer'].toString(), style: thickWhiteTextStyle),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  SizedBox(
                    width: 170.0,
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'].toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: blackHeadingStyle,
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          item['qty'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: subHeadingStyle,
                        ),
                        const SizedBox(height: 3.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\$${item['price']}',
                              style: priceStyle,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '\$${item['oldPrice']}',
                              style: oldStyle,
                            ),
                          ],
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
