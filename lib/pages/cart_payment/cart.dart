import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/payment.dart';
import 'package:newhealthapp/pages/order_medicines/order_medicines.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../api/api_endpoint.dart';
import '../choose_location_address/choose_location.dart';
import '../terms_and_conditions.dart';

class Cart extends StatefulWidget {
  final cartList;

  const Cart({Key? key, required this.cartList}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double cartValue = 0;
  int totalOldPrice = 0;
  late int deliveryCharge = 0;
  bool isLoading = true;

  dynamic cartList;

  final couponList = [
    {
      'image': 'assets/offer_icon/amazon_pay.png',
      'code': 'No Code Required',
      'title': 'Additional cashback upto ₹5 on Amazon pay | No coupon required',
      'subtitle':
          'Pay via Amazon Pay and get Min ₹1 to Max ₹5 cashback,Valid on min. transaction of ₹3.',
      'expiry': 'Expires In 11 days'
    },
    {
      'image': 'assets/offer_icon/hsbc.jpg',
      'code': 'No Code Required',
      'title': '5% cashback on HSBC Credit card | No coupon code required',
      'subtitle':
          '5% additional cashback up to ₹3 on payment made via HSBC Credit card on a minimum transaction of ₹10',
      'expiry': 'Expires In 12 days'
    },
    {
      'image': 'assets/offer_icon/curefit.png',
      'code': 'CULTFIT5',
      'title':
          'Use code : CULTFIT5 | Get 5% OFF on Live Training Sessions with Curefit',
      'subtitle': '5% OFF on Live Training Sessions with Curefit',
      'expiry': 'Expires In last 13 days'
    }
  ];

  @override
  void initState() {
    super.initState();
    print(address);
    // getCartItemsList();
    cartList = widget.cartList;
    createDeliveryDate();
    calculateCartValue();
    calculateTotalOldPrice();
    getDeliveryCharge();
    setState(() {
      isLoading = false;
    });
  }

  String? date;

  createDeliveryDate() {
    DateTime now = DateTime.now();
    DateTime deliveryDate = now.add(Duration(days: 3));
    final f = new DateFormat('dd-MM-yyyy');
    date = f.format(deliveryDate!);
    print(date);
  }

  getCartItemsList() async {
    final data = await ApiProvider.getcartItems();
    print(data);
    setState(() {
      cartList = data["data"][0]["cartItems"];
    });
    print("cart list length=======" + cartList.length.toString());
  }

  // calculateCartValue() {
  //   if (cartItemList.length > 0) {
  //     cartValue = 0;
  //     for (int i = 0; i < cartItemList.length; i++) {
  //       int price = int.parse(cartItemList[i]['price'].toString());
  //       int qty = int.parse(cartItemList[i]['selectedQty'].toString());
  //       int total = price * qty;
  //       cartValue = cartValue + total;
  //     }
  //     setState(() {
  //       cartValue = cartValue;
  //     });
  //   } else {
  //     setState(() {
  //       cartValue = 0;
  //     });
  //   }
  // }

  calculateCartValue() {
    if (cartList.length > 0) {
      cartValue = 0;
      for (int i = 0; i < cartList.length; i++) {
        double price = double.parse(cartList[i]['price'].toString());
        int qty = int.parse(cartList[i]['quantity'].toString());
        double total = price * qty;
        cartValue = cartValue + total;
      }
      setState(() {
        cartValue = cartValue;
      });
    } else {
      setState(() {
        cartValue = 0;
      });
    }
  }

  calculateTotalOldPrice() {
    if (cartList.length > 0) {
      totalOldPrice = 0;
      for (int i = 0; i < cartList.length; i++) {
        int price = int.parse(cartList[i]['product']['price'].toString());
        int qty = int.parse(cartList[i]['quantity'].toString());
        int total = price * qty;
        totalOldPrice = totalOldPrice + total;
      }
      setState(() {
        totalOldPrice = totalOldPrice;
      });
    } else {
      setState(() {
        totalOldPrice = 0;
      });
    }
  }

  getDeliveryCharge() {
    if (cartValue > 10) {
      setState(() {
        deliveryCharge = 0;
      });
    } else {
      setState(() {
        deliveryCharge = 5;
      });
    }
  }

  /// TODO implement remove items from cart
  deleteCartItemDialogue(index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 130.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Delete cart item?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'No',
                          style: primaryColorTextButtonTextStyle,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        ApiProvider api = ApiProvider();
                        EasyLoading.show(maskType: EasyLoadingMaskType.black);
                        await api
                            .removeFromCart(cartList[index]['product']['_id']);
                        EasyLoading.dismiss();
                        setState(() {
                          cartList.removeAt(index);
                        });
                        calculateCartValue();
                        calculateTotalOldPrice();
                        getDeliveryCharge();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Yes',
                          style: whiteTextButtonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // selectQtyDialogue(index) {
  //   double width = MediaQuery.of(context).size.width;
  //   final item = cartItemList[index];
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return Dialog(
  //         elevation: 0.0,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         child: Wrap(
  //           children: [
  //             Container(
  //               padding: EdgeInsets.only(
  //                   right: fixPadding * 1.5,
  //                   left: fixPadding * 1.5,
  //                   top: fixPadding,
  //                   bottom: fixPadding),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text('Select Quantity', style: primaryColorBigHeadingStyle),
  //                   widthSpace,
  //                   IconButton(
  //                     icon: Icon(Icons.close, color: primaryColor),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               width: width,
  //               height: 0.6,
  //               color: primaryColor,
  //             ),
  //
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   cartItemList.removeAt(index);
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: Colors.transparent,
  //                 child: Text('Remove item', style: primaryColorHeadingStyle),
  //               ),
  //             ),
  //             // 1
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   item['selectedQty'] = 1;
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: (item['selectedQty'] == 1)
  //                     ? lightGreyColor
  //                     : Colors.transparent,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('1', style: primaryColorHeadingStyle),
  //                     (item['selectedQty'] == 1)
  //                         ? Container(
  //                             width: 26.0,
  //                             height: 26.0,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(13.0),
  //                                 color: redColor),
  //                             child: Icon(Icons.check,
  //                                 size: 18.0, color: whiteColor),
  //                           )
  //                         : Container(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //             // 2
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   item['selectedQty'] = 2;
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: (item['selectedQty'] == 2)
  //                     ? lightGreyColor
  //                     : Colors.transparent,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('2', style: primaryColorHeadingStyle),
  //                     (item['selectedQty'] == 2)
  //                         ? Container(
  //                             width: 26.0,
  //                             height: 26.0,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(13.0),
  //                                 color: redColor),
  //                             child: Icon(Icons.check,
  //                                 size: 18.0, color: whiteColor),
  //                           )
  //                         : Container(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //             // 3
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   item['selectedQty'] = 3;
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: (item['selectedQty'] == 3)
  //                     ? lightGreyColor
  //                     : Colors.transparent,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('3', style: primaryColorHeadingStyle),
  //                     (item['selectedQty'] == 3)
  //                         ? Container(
  //                             width: 26.0,
  //                             height: 26.0,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(13.0),
  //                                 color: redColor),
  //                             child: Icon(Icons.check,
  //                                 size: 18.0, color: whiteColor),
  //                           )
  //                         : Container(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //             //4
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   item['selectedQty'] = 4;
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: (item['selectedQty'] == 4)
  //                     ? lightGreyColor
  //                     : Colors.transparent,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('4', style: primaryColorHeadingStyle),
  //                     (item['selectedQty'] == 4)
  //                         ? Container(
  //                             width: 26.0,
  //                             height: 26.0,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(13.0),
  //                                 color: redColor),
  //                             child: Icon(Icons.check,
  //                                 size: 18.0, color: whiteColor),
  //                           )
  //                         : Container(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //
  //             // 5
  //             InkWell(
  //               onTap: () {
  //                 setState(() {
  //                   item['selectedQty'] = 5;
  //                 });
  //                 calculateCartValue();
  //                 calculateTotalOldPrice();
  //                 getDeliveryCharge();
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: width,
  //                 padding: EdgeInsets.all(fixPadding * 1.5),
  //                 color: (item['selectedQty'] == 5)
  //                     ? lightGreyColor
  //                     : Colors.transparent,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Text('5', style: primaryColorHeadingStyle),
  //                         widthSpace,
  //                         Text('Max Qty', style: lightPrimaryColorTextStyle),
  //                       ],
  //                     ),
  //                     (item['selectedQty'] == 5)
  //                         ? Container(
  //                             width: 26.0,
  //                             height: 26.0,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(13.0),
  //                                 color: redColor),
  //                             child: Icon(Icons.check,
  //                                 size: 18.0, color: whiteColor),
  //                           )
  //                         : Container(),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('${cartList.length} Item in Cart', style: appBarTitleStyle),
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
        ],
      ),
      bottomNavigationBar: (cartList.length > 0)
          ? Material(
              elevation: 5.0,
              child: Container(
                color: Colors.white,
                width: width,
                height: 170.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: 100.0,
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(fixPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70.0,
                            height: 70.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: Image.asset('assets/icons/icon_9.png',
                                width: 50.0, fit: BoxFit.fitWidth),
                          ),
                          widthSpace,
                          SizedBox(
                            width:
                                width - (fixPadding * 2.0 + 70.0 + 10.0 + 65.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Deliver to', style: subHeadingStyle),
                                    widthSpace,
                                    // Text(address,
                                    //     style: subHeadingBoldStyle),
                                  ],
                                ),
                                heightSpace,
                                Text(
                                  address,
                                  overflow: TextOverflow.ellipsis,
                                  style: subHeadingBoldStyle,
                                ),
                                heightSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Delivery by:',
                                        style: subHeadingStyle),
                                    widthSpace,
                                    Text('$date', style: subHeadingBoldStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ChooseLocation(),
                                  )).then((value) async {
                                Future<SharedPreferences> s =
                                    SharedPreferences.getInstance();
                                SharedPreferences sp = await s;
                                print(value);
                                if (value != null) {
                                  address = value;
                                } else {
                                  address = address;
                                }
                                sp.setString("ADDRESS", "$value");
                                setState(() {});
                              });
                            },
                            child: SizedBox(
                              width: 65.0,
                              child: Text(
                                'Change'.toUpperCase(),
                                style: primaryColorHeadingStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70.0,
                      padding: EdgeInsets.all(fixPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            alignment: Alignment.center,
                            child: Text('₹$cartValue', style: priceStyle),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () {
                              List<dynamic> cartItems = [];
                              for (int i = 0; i < cartList.length; i++) {
                                var item = {
                                  "productId": cartList[i]['product']['_id'],
                                  "payablePrice":
                                      '${(cartList[i]["quantity"] * cartList[i]["price"])}',
                                  "purchasedQty": cartList[i]['quantity']
                                };
                                cartItems.add(item);
                              }
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Payment(cartItems: cartItems)));
                            },
                            child: Container(
                              width: width - (fixPadding * 2.0 + 100.0),
                              height: 50.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: primaryColor,
                              ),
                              child: Text(
                                'Proceed to Payment',
                                style: appBarTitleStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: 0.0,
            ),
      body: isLoading
          ? CircularProgressIndicator()
          : ListView(
              children: [
                (cartList.length > 0) ? cartWithItem() : emptyCart(),
              ],
            ),
    );
  }

  ///TODO work on this
  cartWithItem() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          color: whiteColor,
          child: Container(
            width: width,
            margin: EdgeInsets.all(fixPadding * 2.0),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              strokeWidth: 1.2,
              padding: EdgeInsets.all(fixPadding * 0.5),
              color: greyColor.withOpacity(0.6),
              child: ClipRRect(
                borderRadius: BorderRadius.all(const Radius.circular(10)),
                child: SizedBox(
                  width: width - (fixPadding * 2.0 + 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_12.png',
                          width: 18.0, fit: BoxFit.fitWidth),
                      widthSpace,
                      Text('Free delivery with cart value above ₹10',
                          style: searchTextStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        getCartItemList(),
        // Add More Item Start
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: OrderMedicines()));
          },
          child: Container(
            width: width,
            padding: EdgeInsets.all(fixPadding * 2.0),
            color: whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Add More Items', style: primaryColorHeadingStyle),
                Container(
                  width: 28.0,
                  height: 28.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(width: 0.7, color: primaryColor),
                  ),
                  child: Icon(Icons.add, size: 20.0, color: primaryColor),
                ),
              ],
            ),
          ),
        ),
        // Add More Item End
        heightSpace,
        heightSpace,
        // Hand picked item for you Start

        // HandpickedItemGrid(),

        // Hand picked item for you End
        heightSpace,
        heightSpace,
        // Apply Coupon Start
        applyCoupon(),
        // Apply Coupon End
        heightSpace,
        heightSpace,
        // Additional Notes Start
        additionalNotes(),
        // Additional Notes End
        heightSpace,
        heightSpace,
        // Terms and Condition Start
        termsAndCondition(),
        // Terms and Condition End
      ],
    );
  }

  /// TODO use future builder here
  getCartItemList() {
    double width = MediaQuery.of(context).size.width;
    return ColumnBuilder(
      itemCount: cartList.length,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      itemBuilder: (context, index) {
        final data = cartList[index];
        return Container(
          width: width,
          padding: EdgeInsets.all(fixPadding * 2.0),
          margin: EdgeInsets.only(bottom: fixPadding * 0.5),
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
                        data['product']['productPictures'][0]['filename']),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              widthSpace,
              Container(
                width: width - (fixPadding * 4.0 + 50.0 + 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width:
                              width - (fixPadding * 4.0 + 50.0 + 10.0 + 25.0),
                          child: Text(data['product']['title'].toString(),
                              style: primaryColorHeadingStyle),
                        ),
                        InkWell(
                          onTap: () {
                            deleteCartItemDialogue(index);
                          },
                          child: Icon(
                            Icons.delete,
                            size: 22.0,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        'By ${data['product']['manufacturer_name']}'
                            .toUpperCase(),
                        style: subHeadingStyle),
                    heightSpace,
                    Text('${data['quantity']}'.toUpperCase(),
                        style: thickPrimaryColorHeadingStyle),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('₹${data['product']['discount_price']}',
                            style: priceStyle),
                        widthSpace,
                        Text('₹${data['product']['price']}', style: oldStyle),
                        widthSpace,
                        Container(
                          padding: EdgeInsets.only(
                              right: 5.0, left: 5.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                              '${data['product']['discount_percentage']}'
                                  .toUpperCase(),
                              style: thickWhiteTextStyle),
                        ),
                      ],
                    ),
                    heightSpace,
                    Container(
                      width: 80.0,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(width: 0.6, color: primaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Qty ${data['quantity']}',
                              style: primaryColorHeadingStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  applyCoupon() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _applyCouponModalBottomSheet();
            },
            child: Container(
              width: width - fixPadding * 4.0,
              padding: EdgeInsets.all(fixPadding * 1.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(width: 1.0, color: primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_13.png',
                          width: 25.0, fit: BoxFit.fitWidth),
                      widthSpace,
                      Text('Apply Coupon', style: primaryColorHeadingStyle),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,
                      size: 20.0, color: primaryColor),
                ],
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Cart Value', style: searchTextStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('₹$totalOldPrice', style: oldStyle),
                  Text('₹$cartValue', style: primaryColorHeadingStyle),
                ],
              ),
            ],
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Delivery Charge', style: searchTextStyle),
              Text('₹$deliveryCharge', style: primaryColorHeadingStyle),
            ],
          ),
          heightSpace,
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 4.0,
            dashColor: primaryColor.withOpacity(0.7),
            dashRadius: 0.0,
            dashGapLength: 4.0,
            dashGapColor: Colors.transparent,
            dashGapRadius: 0.0,
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Amount to be paid', style: primaryColorHeadingStyle),
              Text('₹${cartValue + deliveryCharge}',
                  style: primaryColorHeadingStyle),
            ],
          ),
          heightSpace,
          heightSpace,
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(8),
            strokeWidth: 0.8,
            padding: EdgeInsets.all(0),
            color: primaryColor,
            child: Container(
              padding: EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.grey[100],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26.0,
                    height: 26.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: Colors.orange,
                    ),
                    child: Icon(
                      Icons.attach_money,
                      size: 18.0,
                      color: whiteColor,
                    ),
                  ),
                  widthSpace,
                  Container(
                    width: width -
                        (fixPadding * 4.0 + fixPadding * 2.0 + 26.0 + 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Total savings of ₹${totalOldPrice - cartValue} on this order',
                            style: primaryColorHeadingStyle),
                        heightSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('MRP Discount',
                                style: primaryColorDescTextStyle),
                            Text('₹${totalOldPrice - cartValue}',
                                style: primaryColorDescTextStyle),
                          ],
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

  // Bottom Sheet for Apply Coupon Starts Here
  void _applyCouponModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                // height: height,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.only(
                          right: fixPadding * 2.0,
                          left: fixPadding * 2.0,
                          top: fixPadding * 0.7,
                          bottom: fixPadding * 0.7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Apply Coupon',
                              style: primaryColorBigHeadingStyle),
                          IconButton(
                            icon: Icon(Icons.close, color: primaryColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 3,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: EdgeInsets.all(fixPadding * 2.0),
                            color: Colors.grey[200],
                            child: Container(
                              height: 50.0,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    width: 0.8,
                                    color: greyColor.withOpacity(0.6)),
                              ),
                              child: TextField(
                                style: searchTextStyle,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Apply Coupon Code',
                                  hintStyle: searchTextStyle,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: InputBorder.none,
                                  suffix: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Apply',
                                        style: primaryColorHeadingStyle),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Coupon List Start
                          ColumnBuilder(
                            itemCount: couponList.length,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            itemBuilder: (context, index) {
                              final item = couponList[index];
                              return Container(
                                width: width,
                                padding: EdgeInsets.only(
                                    top: fixPadding * 2.0,
                                    right: fixPadding * 2.0,
                                    left: fixPadding * 2.0),
                                color: whiteColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(12),
                                              strokeWidth: 0.8,
                                              color: Colors.orange,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                child: Container(
                                                  width: 100.0,
                                                  height: 50.0,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                      item['image'].toString(),
                                                      height: 50.0,
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              ),
                                            ),
                                            (item['code'] != 'No Code Required')
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      widthSpace,
                                                      Container(
                                                        width: 0.8,
                                                        height: 35.0,
                                                        color: Colors.orange,
                                                      ),
                                                      widthSpace,
                                                      Text(
                                                          item['code']
                                                              .toString(),
                                                          style:
                                                              thickOrangeColorHeadingStyle),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        Container(
                                          width: 100.0,
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              if (item['code'] ==
                                                  'No Code Required') {
                                              } else {
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text(
                                                (item['code'] ==
                                                        'No Code Required')
                                                    ? item['code'].toString()
                                                    : 'Apply',
                                                style:
                                                    primaryColorHeadingStyle),
                                          ),
                                        ),
                                      ],
                                    ),
                                    heightSpace,
                                    Text(item['title'].toString(),
                                        style: primaryColorHeadingStyle),
                                    heightSpace,
                                    Text(item['subtitle'].toString(),
                                        style: subHeadingStyle),
                                    heightSpace,
                                    Text(item['expiry'].toString(),
                                        style: primaryColorTextButtonTextStyle),
                                    heightSpace,
                                    heightSpace,
                                    (index != (couponList.length - 1))
                                        ? Container(
                                            width: width - fixPadding * 4.0,
                                            height: 0.8,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  // Bottom Sheet for Apply Coupon Ends Here

  additionalNotes() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: EdgeInsets.all(fixPadding * 2.0),
      color: whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Notes', style: primaryColorHeadingStyle),
          heightSpace,
          Container(
            width: width - (fixPadding * 4.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              style: notePrimaryColorTextStyle,
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    'Enter any additional information regarding your order',
                hintStyle: noteHintTextStyle,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greyColor, width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: greyColor, width: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  termsAndCondition() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: whiteColor,
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        children: [
          getTermsTile(
              'A licensed pharmacy would be delivering your order basis availability of product & fastest delivery.',
              ''),
          getTermsTile(
              'Prices are indicative and may change after billing.', ''),
          getTermsTile(
              'HealthMeds is a technology platform to connect sellers and buyers and is not involved in sales of any product. Offer for sale on the products and services are provided/sold by the sellers only. For detail read Terms and Conditions.',
              'Terms and Conditions'),
        ],
      ),
    );
  }

  getTermsTile(String desc, String action) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width - fixPadding * 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.only(top: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: primaryColor,
                ),
              ),
              widthSpace,
              Container(
                width: width - (fixPadding * 4.0 + 8.0 + 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      desc,
                      style: primaryColorDescTextStyle,
                    ),
                    (action != '')
                        ? InkWell(
                            onTap: () {
                              if (action == 'Terms and Conditions') {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: TermsAndConditions()));
                              }
                            },
                            child: Text(
                              action,
                              style: primaryColorTextButtonTextStyle,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  emptyCart() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          height: 260.0,
          color: primaryColor,
          padding: EdgeInsets.all(fixPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                strokeWidth: 0.4,
                padding: EdgeInsets.all(fixPadding),
                color: whiteColor,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getDescTile(
                          Icon(Icons.local_offer,
                              color: whiteColor, size: 15.0),
                          'Flat',
                          '15% Off'),
                      getDescTile(
                          Icon(Icons.security, color: whiteColor, size: 15.0),
                          '1 Lakh+',
                          'Products'),
                      getDescTile(
                          Icon(Icons.flip_to_back,
                              color: whiteColor, size: 15.0),
                          'Easy',
                          'Returns'),
                    ],
                  ),
                ),
              ),
              heightSpace,
              heightSpace,
              Text('Search medicines/healthcare products',
                  style: thickWhiteTextStyle),
              heightSpace,
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: Search()));
                },
                child: Container(
                  width: width - fixPadding * 2.0,
                  padding: EdgeInsets.all(fixPadding * 0.9),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: whiteColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: primaryColor, size: 18.0),
                      widthSpace,
                      Text(
                        'Search medicines/healthcare products',
                        style: searchTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: width,
          height: 200.0,
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                right: fixPadding * 2.0,
                child: Image.asset('assets/empty_cart.png',
                    width: 150.0, fit: BoxFit.fitWidth),
              ),
              Positioned(
                top: fixPadding * 2.0,
                left: fixPadding * 2.0,
                child: SizedBox(
                  width: 150.0,
                  child: Text(
                    'Your Cart is Empty!',
                    style: primaryColorExtraBigHeadingStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getDescTile(Icon icon, String title1, String title2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(width: 0.7, color: whiteColor),
          ),
          child: icon,
        ),
        widthSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: thickWhiteTextStyle,
            ),
            Text(
              title2,
              style: thickWhiteTextStyle,
            )
          ],
        ),
      ],
    );
  }
}
