import 'dart:io';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newhealthapp/Model/Banner/Bannerm.dart';
import 'package:newhealthapp/Model/CartItemModel/cartmodel.dart';
import 'package:newhealthapp/Model/DealOfTheDayM/dealoftheday.dart';
import 'package:newhealthapp/Model/FeaturedM/featuredm.dart';
import 'package:newhealthapp/Model/Handpicked/handpick.dart';
import 'package:newhealthapp/Model/TopCategory/viewcategories.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/choose_location_address/select_address.dart';
import 'package:newhealthapp/pages/dial_screen/callingScreen.dart';
import 'package:newhealthapp/pages/home/prevoius_order_row.dart';
import 'package:newhealthapp/pages/offer/offer.dart';
import 'package:newhealthapp/pages/productaddtocard/productaddtocart.dart';
import 'package:newhealthapp/pages/products_list/productList.dart';
import 'package:newhealthapp/pages/products_list/product_list.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:page_transition/page_transition.dart';
import 'discount_grid.dart';
import 'featured_brand_grid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

late String user_address;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String loc = 'Select Location';
  String? receivedAddress;
  int notificationCount = 0;
  String PhoneNumber = '9876543210';

  ///This method is used for fetch banner data
/*
  getAllBannerData() async {
    try {
      final cp = await ApiProvider().getReq(endpoint: getbannerurl);
      if (cp.data[0] != null) {
        // print("condition Check");
        final urldata = bannerGetMFromJson(cp.data);
        for (int i = 0; i < urldata.data!.length; i++) {
          _item = urldata.data!.toList();
        }
        // for (int j = 0; j < _item!.length; j++) {
        //   print("==getItem${_item![j].bannerImage}");
        // }
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
    // final url = urldata.
  }
*/
  var addressAdd;

  // gettopcategoryitems() async {
  //   try {
  //     final cp = await ApiProvider().getReq(endpoint: categoryitemUrl);
  //     // print("getCATEGORYITEMS:${cp.data}");
  //     if (cp.data[0] != null) {
  //       // print("condition Check");
  //       List<ViewTopCategorym> urldata = viewTopCategorymFromJson(cp.data);
  //       for (int i = 0; i < urldata.length; i++) {
  //         // print((urldata[i].topCategories).toString());
  //         // if (urldata[i].topCategories.toString().contains('yes')) {
  //           _item1.add(CategorycheckGetM(
  //               id: urldata[i].id,
  //               image: urldata[i].image,
  //               name: urldata[i].name));
  //           print("${urldata[i].name}+${urldata[i].topCategories}");
  //         }
  //       // }
  //       // for(int j =0 ; j<_item1.length;j++){
  //       //   print("=====(GeT In  own List)= ${_item1[j].id} ${_item1[j].name}   ${_item1[j].image}");
  //       // }
  //     }
  //     setState(() {});
  //   } catch (e) {
  //     print(e);
  //   }
  //   // final url = urldata.
  // }

  @override
  void initState() {
    setAddress();
    getPhoneNumber();
    getAddress();
    gethandpickerdata();
    getFeaturedata();
    getDealOfThedata();
    showNotification();
    // TODO: implement initState
    super.initState();
  }

  Future setAddress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    sp.setString("ADDRESS", "$loc");
  }

  Future getAddress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    addressAdd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressAdd");
  }

  openWhatsapp() async {
    //TODO add respective numbers and link
    var whatsapp = "+917999590290";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=Hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("Hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("Whatsapp not installed")));
      }
    }
  }

  ///This method is used for show notricafication on buy Icon
  showNotification() async {
    final cp = await getphoneNumber();
    CartItemDetail item = cartItemDetailFromJson(cp.data);
    setState(() {
      notificationCount = item.data!.length <= 0 ? 0 : item.data!.length;
    });
  }

  getPhoneNumber() async {
    final ApiResponse cp = await ApiProvider().postandGet();
    List<PhoneNumbermodel> item = phoneNumbermodelFromJson(cp.data);
    setState(() {
      PhoneNumber = (item.length <= 0 ? "+919876543210" : item[0].phone)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomNavigationBar: NewBottomNavigationBar(),
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HealthMeds',
              style: appBarTitleStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Deliver To',
                  style: thinWhiteTextStyle,
                ),
                const SizedBox(width: 4.0),
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
                      getAddress();
                    });
                    print('here');
                    print(receivedAddress);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          //address ?? addressAdd ?? 'No Address',
                          address,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20.0, color: whiteColor),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Offer()));
            },
            icon: const Icon(Icons.local_offer),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Container(
            width: width,
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
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
              InkWell(
                onTap: () async {
                  await openWhatsapp();
                },
                child: BlinkText(
                  "Didn't find required medicine! Click here to chat instantly on whatsapp",
                  style: TextStyle(fontSize: 15.0, color: Colors.redAccent),
                  beginColor: Colors.white,
                  endColor: Colors.orange,
                  times: 10,
                  duration: Duration(seconds: 3),
                  // durtaion: Duration(seconds: 1)
                ),
              ),
            ]),
          ),
        ),
      ),
      body: ListView(
        children: [
          /// Main Slider Start
          Container(
            height: 200,
            child: FutureBuilder(
              future: getBannerdata(),
              builder: (BuildContext context, AsyncSnapshot s) {
                if (s.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SizedBox(
                    child: CircularProgressIndicator(),
                    height: 40,
                    width: 40,
                  ));
                } else if (s.hasData &&
                    s.connectionState == ConnectionState.done) {
                  final urldata = bannerGetMFromJson(s.data.data);
                  // print("here");
                  // print(urldata);
                  return Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return FadeInImage.assetNetwork(
                        placeholder: cupertinoActivityIndicatorSmall,
                        placeholderCacheHeight: 20,
                        image: imagebaseurl +
                            urldata.data![index].bannerImage.toString(),
                        fit: BoxFit.cover,
                      );
                    },
                    autoplay: true,
                    itemCount:
                        urldata.data!.length < 0 ? 1 : urldata.data!.length,
                    pagination: const SwiperPagination(),
                  );
                }
                return const Center(
                    child: Text(
                  "OOPS! NO DATA!",
                  style: TextStyle(color: Colors.white),
                ));
              },
            ),
          ),
          // MainSlider(_item ?? []),
          // Main Slider Ends
          // Previous Order Row Start
          PreviousOrder(),
          // Previous Order Row Ends
          // Doscount Grid Start
          DiscountGrid(),
          // Doscount Grid Ends
          heightSpace,
          heightSpace,

          ///Handpicked Item Grid Start
          Container(
            width: width,
            color: whiteColor,
            padding: EdgeInsets.only(
                top: fixPadding * 2.0, bottom: fixPadding * 2.0),
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
                SizedBox(
                    width: width,
                    height: 275.0,
                    child:
                        //todo need to uncomment
                        FutureBuilder(
                      future: gethandpickerdata(),
                      builder: (BuildContext context, AsyncSnapshot s) {
                        if (s.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (s.hasData &&
                            s.connectionState == ConnectionState.done) {
                          HandpickedGetM items =
                              handpickedGetMFromJson(s.data.data);
                          return ListView.builder(
                            itemCount: items.response!.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // final item = handpickedItemList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ProductItem(
                                            id: items.response![index].id,
                                          )));
                                },
                                child: Container(
                                  width: 170.0,
                                  margin:
                                      (index == (items.response!.length - 1))
                                          ? const EdgeInsets.only(
                                              left: 20.0, right: 20.0)
                                          : const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Hero(
                                            tag: items.response![index]
                                                        .productPictures![0] ==
                                                    null
                                                ? SizedBox()
                                                : '${items.response![index].productPictures![0].filename}',
                                            child: Container(
                                              width: 170.0,
                                              height: 170.0,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    width: 0.6,
                                                    color: primaryColor
                                                        .withOpacity(0.6)),
                                              ),
                                              child: Container(
                                                width: 130.0,
                                                height: 130.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        imagebaseurl +
                                                            items
                                                                .response![
                                                                    index]
                                                                .productPictures![
                                                                    0]
                                                                .filename
                                                                .toString()),
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.9),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Text(
                                                  "${items.response![index].discountPercentage} %"
                                                  // item['offer'].toString(),
                                                  ,
                                                  style: thickWhiteTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3.0),
                                      SizedBox(
                                        width: 170.0,
                                        height: 100.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items.response![index].title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: blackHeadingStyle,
                                            ),
                                            const SizedBox(height: 3.0),
                                            Text(
                                              items.response![index].description
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: subHeadingStyle,
                                            ),
                                            const SizedBox(height: 3.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\₹ ${items.response![index].discountPrice}',
                                                  style: priceStyle,
                                                ),
                                                const SizedBox(width: 5.0),
                                                Text(
                                                  '\₹${items.response![index].price}',
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
                          );
                        }
                        return const Center(
                            child: Text(
                          "OOPS! NO DATA!",
                          style: TextStyle(color: Colors.white),
                        ));
                      },
                    )),
              ],
            ),
          ),

          // HandpickedItemGrid(),

          //Handpicked Item Grid Ends
          heightSpace,
          heightSpace,

          /// Featured Brands Grid Start
          FeaturedBrandGrid(),
          // Featured Brands Grid End
          heightSpace,
          heightSpace,

          /// Deal of the day Start
          Container(
            width: width,
            color: whiteColor,
            padding: EdgeInsets.only(
                top: fixPadding * 2.0, bottom: fixPadding * 2.0),
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
                                textStyle: const TextStyle(
                                    fontSize: 16.0, color: Colors.orange),
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
                SizedBox(
                    width: width,
                    height: 275.0,
                    child:
                        //todo need to uncomment

                        FutureBuilder(
                      future: getDealOfThedata(),
                      builder: (BuildContext context, AsyncSnapshot s) {
                        if (s.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (s.hasData &&
                            s.connectionState == ConnectionState.done) {
                          DealOfTheDayGetM items =
                              dealOfTheDayGetMFromJson(s.data.data);
                          return ListView.builder(
                            itemCount: items.response!.length,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // final item = handpickedItemList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ProductItem(
                                            id: items.response![index].id,
                                          )));
                                },
                                child: Container(
                                  width: 170.0,
                                  margin:
                                      (index == (items.response!.length - 1))
                                          ? const EdgeInsets.only(
                                              left: 20.0, right: 20.0)
                                          : const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Hero(
                                            tag:
                                                '${items.response![index].productPictures![0].filename}',
                                            child: Container(
                                              width: 170.0,
                                              height: 170.0,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    width: 0.6,
                                                    color: primaryColor
                                                        .withOpacity(0.6)),
                                              ),
                                              child: Container(
                                                width: 130.0,
                                                height: 130.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        imagebaseurl +
                                                            items
                                                                .response![
                                                                    index]
                                                                .productPictures![
                                                                    0]
                                                                .filename
                                                                .toString()),
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.9),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Text(
                                                  "${items.response![index].discountPercentage} %"
                                                  // item['offer'].toString(),
                                                  ,
                                                  style: thickWhiteTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3.0),
                                      SizedBox(
                                        width: 170.0,
                                        height: 100.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              items.response![index].title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: blackHeadingStyle,
                                            ),
                                            const SizedBox(height: 3.0),
                                            Text(
                                              items.response![index].description
                                                  .toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: subHeadingStyle,
                                            ),
                                            const SizedBox(height: 3.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '\₹${items.response![index].discountPrice}',
                                                  style: priceStyle,
                                                ),
                                                const SizedBox(width: 5.0),
                                                Text(
                                                  '\₹${items.response![index].discountPrice}',
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
                          );
                        }
                        return const Center(
                            child: Text(
                          "OOPS! NO DATA!",
                          style: TextStyle(color: Colors.black),
                        ));
                      },
                    ))
              ],
            ),
          ),

          // DealOfTheDayGrid(),
          // Deal of the day End
          heightSpace,
          heightSpace,

          /// Top Categories Start
          Container(
            width: width,
            color: whiteColor,
            padding: EdgeInsets.only(
                top: fixPadding * 2.0, bottom: fixPadding * 2.0),
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
                Container(
                  width: width,
                  child: Column(
                    children: [
                      heightSpace,
                      Container(
                          height: 300,
                          width: double.infinity,
                          child: FutureBuilder(
                            future: getopcaterydata(),
                            builder: (context, AsyncSnapshot s) {
                              if (s.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (s.hasData &&
                                  s.connectionState == ConnectionState.done) {
                                List<ViewTopCategorym> _item1 =
                                    viewTopCategorymFromJson(s.data.data);
                                return GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8),
                                    // padding: EdgeInsets.all(20),
                                    itemCount: _item1.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: ProductListAll(
                                                    id: _item1[i]
                                                        .categoryId!
                                                        .id
                                                        .toString(),
                                                  )));
                                        },
                                        child: Container(
                                            child: Column(
                                          children: [
                                            Image.network(
                                              imagebaseurlold +
                                                  _item1[i].image.toString(),
                                              fit: BoxFit.fill,
                                            ),
                                            // Image.network(imagebaseurl+_item1[i].image.toString(),fit: BoxFit.cover,),
                                            SizedBox(
                                              child: Text(
                                                  "${_item1[i].categoryId!.name.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        )),
                                      );
                                    });
                              }
                              return const Center(
                                  child: Text(
                                "OOPS! NO DATA!",
                                style: TextStyle(color: Colors.white),
                              ));
                            },
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ).px12(),

          // TopCategoriesGrid(),

          // Top Categories End
          // heightSpace,
          // heightSpace,
          // Need Help Start
          InkWell(
            onTap: () async {
              const url =
                  "https://wa.me/+9198111 24504?text=Hey buddy,Need help in HealthMed!";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: getTile(
                Icon(Icons.headset_mic, color: primaryColor), 'Need Help?'),
          ),
          // Need Help End
          heightSpace,
          heightSpace,
          // Rate Us Now Start
          InkWell(
            onTap: () {},
            child:
                getTile(Icon(Icons.star, color: primaryColor), 'Rate us Now'),
          ),
          // Rate Us Now End
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  getTile(Icon icon, String title) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: EdgeInsets.only(right: fixPadding * 2.0, left: fixPadding * 2.0),
      padding: EdgeInsets.all(fixPadding * 1.5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(width: 0.4, color: primaryColor.withOpacity(0.6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          widthSpace,
          Text(title, style: primaryColorHeadingStyle),
        ],
      ),
    );
  }
}
