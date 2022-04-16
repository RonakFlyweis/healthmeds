import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_endpoint.dart';
import '../../api/api_provider.dart';

class PreviouslyBoughtItem extends StatefulWidget {
  final previouslyBoughtItem;

  const PreviouslyBoughtItem({Key? key, required this.previouslyBoughtItem})
      : super(key: key);
  @override
  _PreviouslyBoughtItemState createState() => _PreviouslyBoughtItemState();
}

class _PreviouslyBoughtItemState extends State<PreviouslyBoughtItem> {
  int cartItem = 1;
  var addressadd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdress();
  }

  // final previouslyBoughtItem = [
  //   {
  //     'image': 'assets/handpicked_item/handpicked_item_5.png',
  //     'name': 'Revital H Health Supplement Capsules Bottle of 30',
  //     'companyName': 'Revital',
  //     'qty': '30 Capsules(S) in Bottle',
  //     'price': '5',
  //     'oldPrice': '6',
  //     'offer': '15% OFF',
  //     'selectedQty': 1,
  //     'status': 'added to cart'
  //   }
  // ];

  Future getAdress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    // addressadd ='';
    addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Previously Bought Item', style: appBarTitleStyle),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Search()));
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent:
                  Text('$cartItem', style: TextStyle(color: whiteColor)),
              badgeColor: redColor,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
              final data = await ApiProvider.getcartItems();
              final cartList;
              if (data["data"].length == 0) {
                cartList = [];
              } else {
                cartList = data["data"][0]["cartItems"];
              }
              EasyLoading.dismiss();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Cart(
                        cartList: cartList,
                      )));
            },
          ),
        ],
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
                onTap: () async {
                  EasyLoading.show(maskType: EasyLoadingMaskType.black);
                  final data = await ApiProvider.getcartItems();
                  final cartList;
                  if (data["data"].length == 0) {
                    cartList = [];
                  } else {
                    cartList = data["data"][0]["cartItems"];
                  }
                  EasyLoading.dismiss();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Cart(
                            cartList: cartList,
                          )));
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
                    'Continue',
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
          // Deliver To Start
          Container(
            color: scaffoldBgColor,
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on,
                        color: primaryColor.withOpacity(0.6), size: 20.0),
                    widthSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deliver To', style: lightPrimaryColorTextStyle),
                        const SizedBox(height: 5.0),
                        Text(address, style: primaryColorHeadingStyle),
                      ],
                    ),
                  ],
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Text('Change', style: thickPrimaryColorHeadingStyle),
                // ),
              ],
            ),
          ),
          // Deliver To End
          // Item List Start
          (widget.previouslyBoughtItem.length == 0)
              ? Container(
                  padding: EdgeInsets.all(fixPadding * 2.0),
                  width: width,
                  color: whiteColor,
                  alignment: Alignment.center,
                  child: Text('No Previously Bought Item',
                      style: primaryColorHeadingStyle),
                )
              : getItemsList(),
          // Item List End
        ],
      ),
    );
  }

  getItemsList() {
    double width = MediaQuery.of(context).size.width;
    return ColumnBuilder(
      itemCount: widget.previouslyBoughtItem.length,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      itemBuilder: (context, index) {
        final boughtItem = widget.previouslyBoughtItem[index];
        return Container(
          width: width,
          padding: EdgeInsets.all(fixPadding * 2.0),
          margin: EdgeInsets.only(bottom: fixPadding * 1.5),
          color: whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagebaseurl +
                        boughtItem['productId']['productPictures'][0]
                                ['filename']
                            .toString()),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              widthSpace,
              SizedBox(
                width: width - (fixPadding * 4.0 + 50.0 + 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(boughtItem['productId']['title'].toString(),
                        style: primaryColorHeadingStyle),
                    Text(
                        'By ${boughtItem['productId']['brand_name']}'
                            .toUpperCase(),
                        style: subHeadingStyle),
                    heightSpace,
                    Text(
                        'Quantity : ${boughtItem['purchasedQty']}'
                            .toUpperCase(),
                        style: thickPrimaryColorHeadingStyle),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('₹${boughtItem['productId']['discount_price']}',
                            style: priceStyle),
                        widthSpace,
                        Text('₹${boughtItem['productId']['price']}',
                            style: oldStyle),
                        widthSpace,
                        Container(
                          padding: const EdgeInsets.only(
                              right: 5.0, left: 5.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                              '${boughtItem['productId']['discount_percentage']} % OFF'
                                  .toUpperCase(),
                              style: thickWhiteTextStyle),
                        ),
                      ],
                    ),
//                     heightSpace,
//                     (item['status'] == 'added to cart')
//                         ? InkWell(
//                             onTap: () {
// // selectQtyDialogue(index);
//                             },
//                             child: Container(
//                               width: 80.0,
//                               alignment: Alignment.center,
//                               padding: const EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 border:
//                                     Border.all(width: 0.6, color: primaryColor),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text('Qty ${item['selectedQty']}',
//                                       style: primaryColorHeadingStyle),
//                                   const SizedBox(width: 3.0),
//                                   Icon(Icons.arrow_drop_down,
//                                       size: 20.0, color: primaryColor)
//                                 ],
//                               ),
//                             ),
//                           )
//                         : InkWell(
//                             onTap: () {
// // selectQtyDialogue(index);
//                             },
//                             child: Container(
//                               width: 95.0,
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.all(5.0),
//                               decoration: BoxDecoration(
//                                 color: primaryColor,
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               child: Text('Add to Cart',
//                                   style: thickWhiteTextStyle),
//                             ),
//                           ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
