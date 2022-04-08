import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:newhealthapp/Model/CartItemModel/cartmodel.dart';
import 'package:newhealthapp/Model/productsingleview/singleviewproductM.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductItem extends StatefulWidget {
  String? id;

  ProductItem({
    this.id,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int cartItem = 0;
  int selectedQty = 0;
  bool addedToCart = false;
  int pricecount = 0;
  int? v;
  int? notificationCount = 0;
  var addressadd;

  ///This method is used to show notification on but icon
  showNotification() async {
    final cp = await ApiProvider().postandGet();
    CartItemDetail item = cartItemDetailFromJson(cp.data);
    print("=========Notififaction======${item.data!.length}");
    setState(() {
      notificationCount = item.data!.length <= 0 ? 0 : item.data!.length;
    });
  }

  ///This Method is used to get delivering addrress of product
  Future getAdress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
    setState(() {});
  }

  ///This Method is used to get price of selected product
  getprice() async {
    final cp = await ApiProvider()
        .getReq(endpoint: getSingledetailurl, query: widget.id.toString());
    // print("==first=${cp.data}");
    final urldata = singleDetailFromJson(cp.data);
    v = int.parse(urldata.data!.discountPrice.toString());
    setState(() {
      pricecount = v ?? 1;
    });
  }

  @override
  void initState() {
    cartItem = 0;
    super.initState();
    getAdress();
    showNotification();
    getprice();
    print("======1===>${widget.id}");
    getSingleproductDetatil(widget.id.toString());
  }

  // late final productDetails;

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
                          cartItem = cartItem - 1;
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
                    cartItem = 0;
                    pricecount = v!;
                  });
                  setState(() {
                    selectedQty = 1;
                    // if (!addedToCart) {
                    cartItem = cartItem + 1;
                    pricecount = pricecount * cartItem;

                    // }
                    // addedToCart = true;
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
                    cartItem = 0;
                    pricecount = v!;
                  });
                  setState(() {
                    selectedQty = 2;
                    // if (!addedToCart) {
                    cartItem = cartItem + 2;
                    pricecount = pricecount * cartItem;

                    // }
                    // addedToCart = true;
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
                    cartItem = 0;
                    pricecount = v!;
                  });
                  setState(() {
                    selectedQty = 3;
                    // if (!addedToCart) {
                    cartItem = cartItem + 3;
                    pricecount = pricecount * cartItem;
                    // }
                    // addedToCart = true;
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
                    cartItem = 0;
                    pricecount = v!;
                  });
                  setState(() {
                    selectedQty = 4;
                    // if (!addedToCart) {
                    cartItem = cartItem + 4;
                    pricecount = pricecount * cartItem;
                    // }
                    // addedToCart = true;
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
                    cartItem = 0;
                    pricecount = v!;
                  });
                  setState(() {
                    selectedQty = 5;
                    // if (!addedToCart) {
                    cartItem = cartItem + 5;
                    pricecount = pricecount * cartItem;
                    // }
                    // addedToCart = true;
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
                badgeContent: Text('$notificationCount',
                    style: TextStyle(color: whiteColor)),
                badgeColor: redColor,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft, child: Cart()));
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
            padding: EdgeInsets.only(
                right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 90.0,
                  child: Text('$cartItem Item in Cart',
                      style: primaryColorHeadingStyle),
                ),
                SizedBox(
                  width: 100.0,
                  child: Text('₹ $pricecount', style: primaryColorHeadingStyle),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(5.0),
                  onTap: () {
                    if (selectedQty == 0) {
                      Fluttertoast.showToast(msg: ' Plz Selected Quantity');
                    } else {
                      ApiProvider()
                          .addtocart(widget.id, '$selectedQty', '$pricecount');
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Cart()));
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'View Cart',
                      style: appBarTitleStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: getSingleproductDetatil(widget.id.toString()),
          builder: (context, AsyncSnapshot s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (s.hasData && s.connectionState == ConnectionState.done) {
              SingleDetail item = singleDetailFromJson(s.data.data);
              return ListView(
                children: [
                  /// Deliver To Location
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
                                size: 22.0, color: primaryColor),
                            widthSpace,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Deliver To', style: subHeadingStyle),
                                heightSpace,
                                Text(
                                    addressadd != null
                                        ? "${addressadd} "
                                        : " No Address",
                                    style: primaryColorHeadingStyle),
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
                                        child: ChooseLocation()))
                                .then((value) async {
                              Future<SharedPreferences> s =
                                  SharedPreferences.getInstance();
                              SharedPreferences sp = await s;
                              sp.setString("ADDRESS", "$value");
                              // SetAdress();
                              setState(() {});
                              getAdress();
                            });
                          },
                          child: Text('Change',
                              style: primaryColorBigHeadingStyle),
                        ),
                      ],
                    ),
                  ),
                  // Deliver To End

                  /// Product multi Image Show
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: fixPadding * 2.0),
                        child: Container(
                            height: 200,
                            child: Container(
                              height: 100,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return item.data!.productPictures!.length < 0
                                      ? Center(
                                          child: Text(
                                            "NO Banner Found",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        )
                                      : Image.network(
                                          imagebaseurl +
                                              item.data!.productPictures![index]
                                                  .filename
                                                  .toString(),
                                          fit: BoxFit.contain,
                                        );
                                  // imgLists[index].bannerImage
                                },
                                autoplay: true,
                                itemCount:
                                    item.data!.productPictures!.length < 0
                                        ? 1
                                        : item.data!.productPictures!.length,
                                pagination: const SwiperPagination(),
                              ),
                            )),
                      ),
                      heightSpace,
                    ],
                  ),
                  // Product Image Section End

                  // Name Price Section Start

                  // Name Price Section End
                  Container(
                    padding: EdgeInsets.all(fixPadding * 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            // widget.title.toString() item['name']
                            "${item.data!.title}",
                            style: primaryColorBigHeadingStyle),

                        const SizedBox(height: 5.0),
                        Text('By ${item.data!.manufacturerName}',
                            style: thickPrimaryColorHeadingStyle),
                        heightSpace,
                        // Text('\$${widget.discountPrice}', style: priceStyle),
                        Text('\₹${item.data!.discountPrice}',
                            style: priceStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text('\$${widget.price}', style: oldStyle),
                                Text('\₹${item.data!.price}', style: oldStyle),
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
                                  child: Text(
                                      '${item.data!.discountPercentage} %'
                                          // '${widget.discountPercentage}'
                                          .toUpperCase(),
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
                                  border: Border.all(
                                      width: 1.0, color: primaryColor),
                                  color:
                                      (addedToCart) ? whiteColor : primaryColor,
                                ),
                                child: Text('Select Qty',
                                    style: (addedToCart)
                                        ? primaryColorBigHeadingStyle
                                        : whiteBigHeadingStyle),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  greyColorDividerStyle(),

                  // Description & Key Features Section Start
                  descriptionAndKeyFeatures(),
                  // Description & Key Features Section End
                ],
              );
            }
            return const Center(
                child: Text(
              "OOPS! NO DATA!",
              style: TextStyle(color: Colors.white),
            ));
          },
        ));
  }

  greyColorDividerStyle() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: fixPadding * 1.5,
      color: Colors.grey[200],
    );
  }

  descriptionAndKeyFeatures() {
    // final item = widget.productDetails;
    return Container(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: primaryColorHeadingStyle),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: blackNormalTextStyle,
          ),
          heightSpace,
          heightSpace,
          // Key Features Start
          Text('Key Features', style: primaryColorHeadingStyle),
          heightSpace,
          getKeyFeaturesPoint(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          heightSpace,
          getKeyFeaturesPoint(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          heightSpace,
          getKeyFeaturesPoint(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          heightSpace,
          getKeyFeaturesPoint(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
          // Key Features End
          heightSpace,
          heightSpace,
          greyDivider(),
          heightSpace,
          heightSpace,
          // Features and Details Start
          Text('Features & Details', style: primaryColorHeadingStyle),
          heightSpace,
          getFeaturesAndDetailsItem('Brand:', 'company name'),
          heightSpace,
          getFeaturesAndDetailsItem('Manufacturer:', 'manufacturer'),
          heightSpace,
          getFeaturesAndDetailsItem('Country of Origin:', 'countryOfOrigin'),
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
              'If the seal of the product is broken it will be non-returnable.',
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
