import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviouslyBoughtItem extends StatefulWidget {
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

  final previouslyBoughtItem = [
    {
      'image': 'assets/handpicked_item/handpicked_item_5.png',
      'name': 'Revital H Health Supplement Capsules Bottle of 30',
      'companyName': 'Revital',
      'qty': '30 Capsules(S) in Bottle',
      'price': '5',
      'oldPrice': '6',
      'offer': '15% OFF',
      'selectedQty': 1,
      'status': 'added to cart'
    }
  ];



  Future  getAdress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    // addressadd ='';
    addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
    setState(() {
    });
  }


  selectQtyDialogue(index) {
    double width = MediaQuery.of(context).size.width;
    final item = previouslyBoughtItem[index];
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

              (item['status'] == 'added to cart')
                  ? InkWell(
                onTap: () {
                  setState(() {
                    item['status'] = 'removed';
                    item['selectedQty'] = 0;
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
                    item['selectedQty'] = 1;
                    if (item['status'] == 'removed') {
                      cartItem = cartItem + 1;
                    }
                    item['status'] = 'added to cart';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color: (item['selectedQty'] == 1)
                      ? lightGreyColor
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('1', style: primaryColorHeadingStyle),
                      (item['selectedQty'] == 1)
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
                    item['selectedQty'] = 2;
                    if (item['status'] == 'removed') {
                      cartItem = cartItem + 1;
                    }
                    item['status'] = 'added to cart';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color: (item['selectedQty'] == 2)
                      ? lightGreyColor
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('2', style: primaryColorHeadingStyle),
                      (item['selectedQty'] == 2)
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
                    item['selectedQty'] = 3;
                    if (item['status'] == 'removed') {
                      cartItem = cartItem + 1;
                    }
                    item['status'] = 'added to cart';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color: (item['selectedQty'] == 3)
                      ? lightGreyColor
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('3', style: primaryColorHeadingStyle),
                      (item['selectedQty'] == 3)
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
                    item['selectedQty'] = 4;
                    if (item['status'] == 'removed') {
                      cartItem = cartItem + 1;
                    }
                    item['status'] = 'added to cart';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color: (item['selectedQty'] == 4)
                      ? lightGreyColor
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('4', style: primaryColorHeadingStyle),
                      (item['selectedQty'] == 4)
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
                    item['selectedQty'] = 5;
                    if (item['status'] == 'removed') {
                      cartItem = cartItem + 1;
                    }
                    item['status'] = 'added to cart';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  color: (item['selectedQty'] == 5)
                      ? lightGreyColor
                      : Colors.transparent,
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
                      (item['selectedQty'] == 5)
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Previously Bought Items',
            style: appBarTitleStyle),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft, child: Cart()));
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
                        Text('${addressadd ?? 'No Address'}'
                            ,style: primaryColorHeadingStyle),
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
          (previouslyBoughtItem.length == 0)
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
      itemCount: previouslyBoughtItem.length,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      itemBuilder: (context, index) {
        final item = previouslyBoughtItem[index];
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
                    image: AssetImage(item['image'].toString()),
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
                    Text(item['name'].toString(), style: primaryColorHeadingStyle),
                    Text('By ${item['companyName']}'.toUpperCase(),
                        style: subHeadingStyle),
                    heightSpace,
                    Text('${item['qty']}'.toUpperCase(),
                        style: thickPrimaryColorHeadingStyle),
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
                              right: 5.0, left: 5.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text('${item['offer']}'.toUpperCase(),
                              style: thickWhiteTextStyle),
                        ),
                      ],
                    ),
                    heightSpace,
                    (item['status'] == 'added to cart')
                        ? InkWell(
                      onTap: () {
                        selectQtyDialogue(index);
                      },
                      child: Container(
                        width: 80.0,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border:
                          Border.all(width: 0.6, color: primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Qty ${item['selectedQty']}',
                                style: primaryColorHeadingStyle),
                            const SizedBox(width: 3.0),
                            Icon(Icons.arrow_drop_down,
                                size: 20.0, color: primaryColor)
                          ],
                        ),
                      ),
                    )
                        : InkWell(
                      onTap: () {
                        selectQtyDialogue(index);
                      },
                      child: Container(
                        width: 95.0,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text('Add to Cart',
                            style: thickWhiteTextStyle),
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
}
