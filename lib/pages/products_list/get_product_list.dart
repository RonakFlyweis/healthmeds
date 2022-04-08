import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/product/product.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';

class GetProductList extends StatefulWidget {
  @override
  _GetProductListState createState() => _GetProductListState();
}

class _GetProductListState extends State<GetProductList> {
  final allProductList = [
    {
      'name': 'B-protin Chocolate Nutrition Supplement Bottle Of 500 G',
      'companyName': 'B-Protin',
      'image': 'assets/product/product_1/1.png',
      'imageList': [
        'assets/product/product_1/1.png',
        'assets/product/product_1/2.png',
        'assets/product/product_1/3.png',
      ],
      'flavour': ['Chocolate', 'Dry Fruit'],
      'selectedFlavour': 'Chocolate',
      'packSize': ['200g', '500g'],
      'selectedPackSize': '500g',
      'price': '7',
      'oldPrice': '8',
      'offer': '5% Off',
      'manufacturer': 'British Biologicals',
      'countryOfOrigin': 'India'
    },
    {
      'name': 'Himalaya Baby Massage Body Oil Bottle',
      'companyName': 'HIMALAYA',
      'image': 'assets/product/product_2/1.png',
      'imageList': [
        'assets/product/product_2/1.png',
        'assets/product/product_2/2.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['100ml', '200ml', '500ml'],
      'selectedPackSize': '100ml',
      'price': '1.5',
      'oldPrice': '1.8',
      'offer': '20% Off',
      'manufacturer': 'The Himalaya Drug Company',
      'countryOfOrigin': 'India'
    },
    {
      'name': 'Ezee Velwet Tissue Paper Packet',
      'companyName': 'Ezee',
      'image': 'assets/product/product_3/1.png',
      'imageList': ['assets/product/product_3/1.png'],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['50 NO\'s', '100 NO\'s'],
      'selectedPackSize': '100 NO\'s',
      'price': '1',
      'oldPrice': '1.5',
      'offer': '33% Off',
      'manufacturer': 'Alka Lifestyles Private Limited',
      'countryOfOrigin': 'India'
    },
    {
      'name': '3 Ply Mask Packet',
      'companyName': 'N95 Masks',
      'image': 'assets/product/product_4/1.png',
      'imageList': [
        'assets/product/product_4/1.png',
        'assets/product/product_4/2.png',
        'assets/product/product_4/3.png',
        'assets/product/product_4/4.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['50 NO\'s', '100 NO\'s'],
      'selectedPackSize': '50 NO\'s',
      'price': '9',
      'oldPrice': '18',
      'offer': '50% Off',
      'manufacturer': 'Surgical',
      'countryOfOrigin': 'India'
    },
    {
      'name': 'Cipla Maxirich Multivitamin & Minerals Sofgels',
      'companyName': 'Cipla',
      'image': 'assets/product/product_5/1.png',
      'imageList': [
        'assets/product/product_5/1.png',
        'assets/product/product_5/2.png',
        'assets/product/product_5/3.png',
        'assets/product/product_5/4.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': ['10 NO\'s', '30 NO\'s'],
      'selectedPackSize': '10 NO\'s',
      'price': '5',
      'oldPrice': '8',
      'offer': '30% Off',
      'manufacturer': 'Geltec Pvt Ltd',
      'countryOfOrigin': 'India'
    },
    {
      'name': 'Aero Digital Thermometer',
      'companyName': 'N95 Masks & Sanitizers',
      'image': 'assets/product/product_6/1.png',
      'imageList': [
        'assets/product/product_6/1.png',
        'assets/product/product_6/2.png',
        'assets/product/product_6/3.png',
        'assets/product/product_6/4.png',
        'assets/product/product_6/5.png',
        'assets/product/product_6/6.png'
      ],
      'flavour': [],
      'selectedFlavour': '',
      'packSize': [],
      'selectedPackSize': '',
      'price': '2',
      'oldPrice': '4',
      'offer': '50% Off',
      'manufacturer': 'Hemant Surgical Industries Ltd',
      'countryOfOrigin': 'India'
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ColumnBuilder(
      itemCount: allProductList.length,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      itemBuilder: (context, index) {
        final item = allProductList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Product(productDetails: item)));
          },
          child: Column(
            children: [
              Container(
                width: width,
                padding: EdgeInsets.all(fixPadding * 2.0),
                color: whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: '${item['image']}',
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(item['image'].toString()),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    widthSpace,
                    Container(
                      width: width - (fixPadding * 4.0 + 70.0 + 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item['name']} ${item['selectedPackSize']}',
                              style: primaryColorHeadingStyle),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('₹${item['price']}', style: priceStyle),
                              widthSpace,
                              Text('₹${item['oldPrice']}', style: oldStyle),
                              widthSpace,
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 5.0,
                                    left: 5.0,
                                    top: 2.0,
                                    bottom: 2.0),
                                decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text('${item['offer']}'.toUpperCase(),
                                    style: thickWhiteTextStyle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }
}
