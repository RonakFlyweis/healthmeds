import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/product/product.dart';
import 'package:newhealthapp/pages/products_list/product_list.dart';
import 'package:page_transition/page_transition.dart';

class DealOfTheDayGrid extends StatefulWidget {
  @override
  _DealOfTheDayGridState createState() => _DealOfTheDayGridState();
}

class _DealOfTheDayGridState extends State<DealOfTheDayGrid> {

  final delalOfTheDayItemList = [
    {
      'itemId': 1,
      'image': 'assets/deal_of_the_day/deal_of_the_day_1.png',
      'name':
      'Everherb Men\'s Formula - 6 Natural & Safe Herbs - Increases Sperm Count, Vigour & Aids Erectile Dysfunction - 60 Veg Capsules',
      'oldPrice': '12',
      'price': '6',
      'offer': '50% OFF',
      'companyName': 'EverHerb',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_1.png',
        'assets/deal_of_the_day/deal_of_the_day_1.png',
        'assets/deal_of_the_day/deal_of_the_day_1.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Bacfo Pharmaceuticals (india) Ltd',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 2,
      'image': 'assets/deal_of_the_day/deal_of_the_day_2.png',
      'name': 'Garlic Pearls - Natural Way To Heathy Heart & Digestion - 100s',
      'oldPrice': '13',
      'price': '8',
      'offer': '30% OFF',
      'companyName': 'Garlic Pearls',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_2.png',
        'assets/deal_of_the_day/deal_of_the_day_2.png',
        'assets/deal_of_the_day/deal_of_the_day_2.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Sun Pharma',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 3,
      'image': 'assets/deal_of_the_day/deal_of_the_day_3.png',
      'name': 'Softovac O Orange Constipation Powder Container Of 80 G',
      'oldPrice': '15',
      'price': '7',
      'offer': '55% OFF',
      'companyName': 'Softovac',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_3.png',
        'assets/deal_of_the_day/deal_of_the_day_3.png',
        'assets/deal_of_the_day/deal_of_the_day_3.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Softovac',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 4,
      'image': 'assets/deal_of_the_day/deal_of_the_day_4.png',
      'name': 'Fast&up Charge Orange Effervescent Tablets Box Of 60 \'s',
      'oldPrice': '6',
      'price': '4',
      'offer': '20% OFF',
      'companyName': 'FAST & UP',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_4.png',
        'assets/deal_of_the_day/deal_of_the_day_4.png',
        'assets/deal_of_the_day/deal_of_the_day_4.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Fast & Up India',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 5,
      'image': 'assets/deal_of_the_day/deal_of_the_day_5.png',
      'name': 'N95 Mask - Pack Of 5',
      'oldPrice': '5',
      'price': '4',
      'offer': '10% OFF',
      'companyName': 'N95 Masks',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_5.png',
        'assets/deal_of_the_day/deal_of_the_day_5.png',
        'assets/deal_of_the_day/deal_of_the_day_5.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['5 NO\'s', '10 NO\'s'],
      'selectedPackSize': '5 NO\'s',
      'manufacturer': 'Thea Tex Healthcare India',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 6,
      'image': 'assets/deal_of_the_day/deal_of_the_day_6.png',
      'name':
      'Liveasy Wellness Multivitamin Multimineral - Added Ginseng, Grapeseed & Ginkgo Biloba Extracts - Strong Immunity- 60 Tablets',
      'oldPrice': '20',
      'price': '10',
      'offer': '50% OFF',
      'companyName': 'LivEasy',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_6.png',
        'assets/deal_of_the_day/deal_of_the_day_6.png',
        'assets/deal_of_the_day/deal_of_the_day_6.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Zeon Lifesciences Limited',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 7,
      'image': 'assets/deal_of_the_day/deal_of_the_day_7.png',
      'name': 'Kapiva Vigor Max Vitality Capsules Bottle Of 60 \'s',
      'oldPrice': '30',
      'price': '25',
      'offer': '20% OFF',
      'companyName': 'KAPIVA',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_7.png',
        'assets/deal_of_the_day/deal_of_the_day_7.png',
        'assets/deal_of_the_day/deal_of_the_day_7.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Kapiva',
      'countryOfOrigin': 'India'
    },
    {
      'itemId': 8,
      'image': 'assets/deal_of_the_day/deal_of_the_day_8.png',
      'name': 'Cipla Mamaxpert Intimate Wash Bottle Of 100 Ml',
      'oldPrice': '12',
      'price': '10',
      'offer': '10% OFF',
      'companyName': 'Mamaxpert',
      'imageList': [
        'assets/deal_of_the_day/deal_of_the_day_8.png',
        'assets/deal_of_the_day/deal_of_the_day_8.png',
        'assets/deal_of_the_day/deal_of_the_day_8.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'manufacturer': 'Pontika Aerotech Limited',
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
            padding: EdgeInsets.only(
                left: fixPadding * 2.5, right: fixPadding * 2.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deals of the Day',
                      style: blackHeadingStyle,
                    ),
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.av_timer, color: Colors.orange),
                        const SizedBox(width: 5.0),
                        //todo need to remember
                        CountdownTimer(
                          endTime: DateTime.now().millisecondsSinceEpoch +
                              1000000000 * 60,
                          textStyle:
                          const TextStyle(fontSize: 16.0, color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ProductList()));
                  },
                  child: Text(
                    'View All',
                    style: viewAllTextStyle,
                  ),
                ),
              ],
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
      height: 250.0,
      child: ListView.builder(
        itemCount: delalOfTheDayItemList.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = delalOfTheDayItemList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Product(productDetails: item)));
            },
            child: Container(
              width: 170.0,
              margin: (index == (delalOfTheDayItemList.length - 1))
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
                    height: 76.0,
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
