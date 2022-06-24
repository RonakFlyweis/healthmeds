import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_endpoint.dart';
import '../../api/api_provider.dart';
import '../../widgets/bottomnavi.dart';

class Product extends StatefulWidget {
  final productDetails;

  Product({@required this.productDetails});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int current = 0;
  //late String selectedFlavour, selectedPackSize;
  late String selectedPackSize;
  int cartItem = 1;
  int selectedQty = 0;
  bool addedToCart = false;
  late final productDetails;

  @override
  void initState() {
    super.initState();
    // selectedFlavour = widget.productDetails['selectedFlavour'];
    //selectedFlavour = widget.productDetails['selectedFlavour'];
    // selectedPackSize = widget.productDetails['selectedPackSize'];
    selectedPackSize = widget.productDetails['pack_size'];
    print("======>${widget.productDetails}");
    productDetails = widget.productDetails;
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  selectQtyDialogue() {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                    right: fixPadding * 1.5,
                    left: fixPadding * 1.5,
                    top: fixPadding,
                    bottom: fixPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Select Quantity', style: primaryColorBigHeadingStyle),
                    widthSpace,
                    IconButton(
                      icon: Icon(Icons.close, color: primaryColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: 0.6,
                color: primaryColor,
              ),

              (addedToCart)
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          addedToCart = false;
                          selectedQty = 0;
                          // cartItem = cartItem - 1;
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(fixPadding * 1.5),
                        color: Colors.transparent,
                        child: Text('Remove item',
                            style: primaryColorHeadingStyle),
                      ),
                    )
                  : Container(),
              // 1
              InkWell(
                onTap: () {
                  setState(() {
                    selectedQty = 1;
                    if (!addedToCart) {
                      cartItem = cartItem + 1;
                    }
                    addedToCart = true;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color:
                      (selectedQty == 1) ? lightGreyColor : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('1', style: primaryColorHeadingStyle),
                      (selectedQty == 1)
                          ? Container(
                              width: 26.0,
                              height: 26.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: redColor),
                              child: Icon(Icons.check,
                                  size: 18.0, color: whiteColor),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              // 2
              InkWell(
                onTap: () {
                  setState(() {
                    selectedQty = 2;
                    if (!addedToCart) {
                      cartItem = cartItem + 1;
                    }
                    addedToCart = true;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color:
                      (selectedQty == 2) ? lightGreyColor : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('2', style: primaryColorHeadingStyle),
                      (selectedQty == 2)
                          ? Container(
                              width: 26.0,
                              height: 26.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: redColor),
                              child: Icon(Icons.check,
                                  size: 18.0, color: whiteColor),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              // 3
              InkWell(
                onTap: () {
                  setState(() {
                    selectedQty = 3;
                    if (!addedToCart) {
                      cartItem = cartItem + 1;
                    }
                    addedToCart = true;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color:
                      (selectedQty == 3) ? lightGreyColor : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('3', style: primaryColorHeadingStyle),
                      (selectedQty == 3)
                          ? Container(
                              width: 26.0,
                              height: 26.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: redColor),
                              child: Icon(Icons.check,
                                  size: 18.0, color: whiteColor),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              //4
              InkWell(
                onTap: () {
                  setState(() {
                    selectedQty = 4;
                    if (!addedToCart) {
                      cartItem = cartItem + 1;
                    }
                    addedToCart = true;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color:
                      (selectedQty == 4) ? lightGreyColor : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('4', style: primaryColorHeadingStyle),
                      (selectedQty == 4)
                          ? Container(
                              width: 26.0,
                              height: 26.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: redColor),
                              child: Icon(Icons.check,
                                  size: 18.0, color: whiteColor),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),

              // 5
              InkWell(
                onTap: () {
                  setState(() {
                    selectedQty = 5;
                    if (!addedToCart) {
                      cartItem = cartItem + 1;
                    }
                    addedToCart = true;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color:
                      (selectedQty == 5) ? lightGreyColor : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('5', style: primaryColorHeadingStyle),
                          widthSpace,
                          Text('Max Qty', style: lightPrimaryColorTextStyle),
                        ],
                      ),
                      (selectedQty == 5)
                          ? Container(
                              width: 26.0,
                              height: 26.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: redColor),
                              child: Icon(Icons.check,
                                  size: 18.0, color: whiteColor),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final productDetails = widget.productDetails;

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Product Description', style: appBarTitleStyle),
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
          padding:
              EdgeInsets.only(right: fixPadding * 2.0, left: fixPadding * 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 90.0,
                child: Text(
                    // '$cartItem Item in Cart',
                    '$selectedQty quantity selected',
                    style: primaryColorHeadingStyle),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(5.0),

                ///todo Implement add to cart
                onTap: () async {
                  if (selectedQty != 0) {
                    ApiProvider api = ApiProvider();
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                    await api.addtocart(productDetails['_id'], selectedQty, productDetails['discount_price']);
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
                  } else {
                    EasyLoading.showToast('Select some quantity');
                  }
                },
                child: Container(
                  width: width - (fixPadding * 4.0 + 90.0),
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Add To Cart',
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
                    Icon(Icons.location_on, size: 22.0, color: primaryColor),
                    widthSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deliver To', style: subHeadingStyle),
                        heightSpace,
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            //address ?? addressAdd ?? 'No Address',
                            address,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          // child: SelectAddress(),
                          child: ChooseLocation(),
                        )).then((value) async {
                      // loc = value;
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
                      // getAddress();
                    });
                    print('here');
                    // print(receivedAddress);
                  },
                  child: Text('Change', style: primaryColorBigHeadingStyle),
                ),
              ],
            ),
          ),
          // Deliver To End

          // Product Image Section Start
          //todo need to remember
          productImage(productDetails),
          // Product Image Section End

          // Name Price Section Start
          namePriceSection(),
          // Name Price Section End

          greyColorDividerStyle(),

          // Product Options Section Start
          //productOption(),
          // Product Options Section End

          // Description & Key Features Section Start
          descriptionAndKeyFeatures(),
          // Description & Key Features Section End
        ],
      ),
    );
  }

//todo need to remember
  productImage(productDetails) {
    return Column(
      children: [
        Hero(
          tag: '${productDetails['productPictures'][0]['filename']}',
          child: Padding(
            padding: EdgeInsets.only(top: fixPadding * 2.0),
            child: Container(
              height: 200,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  final item = productDetails['productPictures'];
                  return item.length < 0
                      ? Center(
                    child: Text(
                      "NO Banner Found",
                      style:
                      TextStyle(color: Colors.black),
                    ),
                  )
                      : Image.network(
                    imagebaseurl +
                        item[index]
                            ['filename']
                            .toString(),
                    fit: BoxFit.contain,
                  );
                  //   Container(
                  //   height: 100.0,
                  //   margin: EdgeInsets.only(left: fixPadding * 2.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //     border: Border.all(width: 1.0, color: primaryColor),
                  //     image: DecorationImage(
                  //       // image: AssetImage(item.toString()),
                  //       image: NetworkImage(
                  //           imagebaseurl + item['filename'].toString()),
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // );
                },
                autoplay: true,
                itemCount: productDetails['productPictures'].length,
                pagination: const SwiperPagination(),
              ),
            ),
          ),
        ),
        heightSpace,
      ],
    );
  }
  // */

  namePriceSection() {
    final item = widget.productDetails;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['title'], style: primaryColorBigHeadingStyle),
          const SizedBox(height: 5.0),
          Text('By ${item['brand_name']}',
              style: thickPrimaryColorHeadingStyle),
          heightSpace,
          Text('₹${item['discount_price']}', style: priceStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('₹${item['price']}', style: oldStyle),
                  widthSpace,
                  Container(
                    padding: const EdgeInsets.only(
                        right: 5.0, left: 5.0, top: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                        '${item['discount_percentage'] + ' %'}'.toUpperCase(),
                        style: thickWhiteTextStyle),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  selectQtyDialogue();
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: fixPadding,
                      bottom: fixPadding,
                      left: fixPadding * 4.0,
                      right: fixPadding * 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: primaryColor),
                    color: (addedToCart) ? whiteColor : primaryColor,
                  ),
                  child: Text(
                      (addedToCart) ? selectedQty.toString() : 'Select Qty',
                      style: (addedToCart)
                          ? primaryColorBigHeadingStyle
                          : whiteBigHeadingStyle),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  greyColorDividerStyle() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: fixPadding * 1.5,
      color: Colors.grey[200],
    );
  }

  // productOption() {
  //   final item = widget.productDetails;
  //   return Container(
  //     padding: EdgeInsets.all(fixPadding * 2.0),
  //     child: Column(
  //       children: [
  //         (item['flavour'].length > 0)
  //             ? InkWell(
  //           onTap: () {
  //             _selectFlavourModalBottomSheet(context);
  //           },
  //           child: Container(
  //             padding: EdgeInsets.only(
  //                 top: fixPadding * 1.5,
  //                 bottom: fixPadding * 1.5,
  //                 right: fixPadding,
  //                 left: fixPadding),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10.0),
  //               border: Border.all(width: 1.0, color: primaryColor),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('Flavour:', style: subHeadingStyle),
  //                     widthSpace,
  //                     Text(selectedFlavour,
  //                         style: primaryColorHeadingStyle),
  //                   ],
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('${item['flavour'].length - 1} more',
  //                         style: thickPrimaryColorHeadingStyle),
  //                     const SizedBox(width: 3.0),
  //                     Icon(Icons.arrow_forward_ios,
  //                         size: 22.0, color: primaryColor),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //             : Container(),
  //         (item['flavour'].length > 0) ? heightSpace : Container(),
  //         (item['packSize'].length > 0)
  //             ? InkWell(
  //           onTap: () {
  //             _selectPackSizeModalBottomSheet(context);
  //           },
  //           child: Container(
  //             padding: EdgeInsets.only(
  //                 top: fixPadding * 1.5,
  //                 bottom: fixPadding * 1.5,
  //                 right: fixPadding,
  //                 left: fixPadding),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10.0),
  //               border: Border.all(width: 1.0, color: primaryColor),
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('Pack Size:', style: subHeadingStyle),
  //                     widthSpace,
  //                     Text(selectedPackSize,
  //                         style: primaryColorHeadingStyle),
  //                   ],
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Text('${item['packSize'].length - 1} more',
  //                         style: thickPrimaryColorHeadingStyle),
  //                     const SizedBox(width: 3.0),
  //                     Icon(Icons.arrow_forward_ios,
  //                         size: 22.0, color: primaryColor),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //             : Container(),
  //       ],
  //     ),
  //   );
  // }

  // void _selectFlavourModalBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         final item = widget.productDetails;
  //         double width = MediaQuery.of(context).size.width;
  //         return Wrap(
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.all(fixPadding * 2.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Container(
  //                     width: width - (fixPadding * 4.0),
  //                     alignment: Alignment.center,
  //                     child: Text('Select Flavour',
  //                         style: primaryColorBigHeadingStyle),
  //                   ),
  //                   heightSpace,
  //                   SizedBox(
  //                     width: width - (fixPadding * 4.0),
  //                     height: 50.0,
  //                     child: ListView.builder(
  //                       itemCount: item['flavour'].length,
  //                       scrollDirection: Axis.horizontal,
  //                       physics: const BouncingScrollPhysics(),
  //                       itemBuilder: (context, index) {
  //                         return InkWell(
  //                           onTap: () {
  //                             setState(() {
  //                               selectedFlavour =
  //                               '${item['flavour'][index]}';
  //                             });
  //                             Navigator.pop(context);
  //                           },
  //                           child: Container(
  //                             margin: (index ==
  //                                 (item['flavour'].length - 1))
  //                                 ? const EdgeInsets.only(left: 20.0, right: 20.0)
  //                                 : const EdgeInsets.only(left: 20.0),
  //                             child: Container(
  //                               alignment: Alignment.center,
  //                               padding: EdgeInsets.all(fixPadding * 1.5),
  //                               decoration: BoxDecoration(
  //                                 color: whiteColor,
  //                                 borderRadius: BorderRadius.circular(10.0),
  //                                 border: Border.all(
  //                                     width: 1.0,
  //                                     color: (selectedFlavour ==
  //                                         item['flavour'][index].toString())
  //                                         ? primaryColor
  //                                         : Colors.grey.shade300),
  //                               ),
  //                               child: Text('${item['flavour'][index]}',
  //                                   style: thickPrimaryColorHeadingStyle),
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  void _selectPackSizeModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          final item = widget.productDetails;
          double width = MediaQuery.of(context).size.width;
          return Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width - (fixPadding * 4.0),
                      alignment: Alignment.center,
                      child: Text('Select Pack Size',
                          style: primaryColorBigHeadingStyle),
                    ),
                    heightSpace,
                    Container(
                      width: width - (fixPadding * 4.0),
                      height: 55.0,
                      child: ListView.builder(
                        itemCount: item['packSize'].length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedPackSize = '${item['packSize'][index]}';
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: (index == (item['packSize'].length - 1))
                                  ? const EdgeInsets.only(
                                      left: 20.0, right: 20.0)
                                  : const EdgeInsets.only(left: 20.0),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(fixPadding * 1.5),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1.0,
                                      color: (selectedPackSize ==
                                              item['packSize'][index]
                                                  .toString())
                                          ? primaryColor
                                          : Colors.grey.shade300),
                                ),
                                child: Text('${item['packSize'][index]}',
                                    style: thickPrimaryColorHeadingStyle),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  descriptionAndKeyFeatures() {
    final item = widget.productDetails;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: primaryColorHeadingStyle),
          heightSpace,
          Text(
            item['description'],
            //'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: blackNormalTextStyle,
          ),
          heightSpace,
          heightSpace,
          // Key Features Start
          // Text('Key Features', style: primaryColorHeadingStyle),
          // heightSpace,
          // getKeyFeaturesPoint(
          //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          // heightSpace,
          // getKeyFeaturesPoint(
          //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          // heightSpace,
          // getKeyFeaturesPoint(
          //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          // heightSpace,
          // getKeyFeaturesPoint(
          //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          // // Key Features End
          heightSpace,
          heightSpace,
          greyDivider(),
          heightSpace,
          heightSpace,
          // Features and Details Start
          Text('Features & Details', style: primaryColorHeadingStyle),
          heightSpace,
          getFeaturesAndDetailsItem('Brand:', item['brand_name']),
          heightSpace,
          getFeaturesAndDetailsItem('Manufacturer:', item['manufacturer_name']),
          heightSpace,
          getFeaturesAndDetailsItem(
              'Country of Origin:', item['country_origin']),
          // Features and Details End
          heightSpace,
          heightSpace,
          greyDivider(),
          heightSpace,
          heightSpace,
          // Disclaimer Start
          Text('Disclaimer', style: primaryColorHeadingStyle),
          heightSpace,
          Text(
              item['disclaimer'],
              style: primaryColorNormalThinTextStyle),
          // Disclaimer End
        ],
      ),
    );
  }

  getKeyFeaturesPoint(String text) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width - fixPadding * 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            margin: const EdgeInsets.only(top: 4.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.5),
              color: blackColor,
            ),
          ),
          widthSpace,
          SizedBox(
            width: width - (fixPadding * 4.0 + 7.0 + 10.0),
            child: Text(text, style: blackNormalTextStyle),
          ),
        ],
      ),
    );
  }

  getFeaturesAndDetailsItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: primaryColorNormalTextStyle),
        const SizedBox(width: 5.0),
        Text(value, style: primaryColorNormalThinTextStyle),
      ],
    );
  }

  greyDivider() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 1.0,
      color: Colors.grey[300],
    );
  }
}
