import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:newhealthapp/Model/healthcareproductM/mhealthcare.dart';
import 'package:newhealthapp/api/api_endpoint.dart';

// import 'package:healthmeds/constants/constants.dart';
// import 'package:healthmeds/pages/cart_payment/cart_payment.dart';
// import 'package:healthmeds/pages/choose_location_address/choose_location.dart';
// import 'package:healthmeds/pages/offer/offer.dart';
// import 'package:healthmeds/pages/products_list/product_list.dart';
// import 'package:healthmeds/pages/search/search.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/products_list/product_list.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthCare extends StatefulWidget {
  @override
  _HealthCareState createState() => _HealthCareState();
}

class _HealthCareState extends State<HealthCare> {
  Stream get healthcareproduct async* {
    print('InSide Stream');
    yield await getHealthCareProduct();
  }

  getHealthCareProducts() async {
    var url = 'https://helthmade-1234.herokuapp.com/viewHealthCareProduct';

    try {
      http.Response r = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(r.request);
      var body = jsonDecode(r.body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getAdress();
    super.initState();
  }

  var addressadd;

  Future getAdress() async {
    print('here');
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    print(sp);
    // addressadd ='';
    addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Healthcare Products',
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
                      print(value);
                      if (value != null) {
                        address = value;
                      } else {
                        address = address;
                      }
                      sp.setString("ADDRESS", "$value");
                      // SetAdress();
                      setState(() {});
                      getAdress();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.3,
                        child: Text(
                          //address ?? addressadd ?? 'No Address',
                          address,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis
                          ),
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
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft, child: Offer()));
            },
            icon: const Icon(Icons.local_offer),
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text('1', style: TextStyle(color: whiteColor)),
              badgeColor: redColor,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.rightToLeft, child: Cart()));
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Container(
            width: width,
            padding: EdgeInsets.all(fixPadding),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         type: PageTransitionType.rightToLeft, child: Search()));
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
          ),
        ),
      ),
      body: FutureBuilder(
          future: getHealthCareProducts(),
          builder: (BuildContext context, AsyncSnapshot s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (s.hasData && s.connectionState == ConnectionState.done) {
              //List<Healthcaremodel> item = healthcaremodelFromJson(s.data.data);
              final data = s.data['data'];
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  // final item = offerList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ProductList()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: fixPadding * 2.0,
                        right: fixPadding * 2.0,
                        left: fixPadding * 2.0,
                        bottom:
                            (i == (data.length - 1)) ? fixPadding * 2.0 : 0.0,
                      ),
                      padding: EdgeInsets.all(fixPadding * 2.0),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 0.2, color: primaryColor),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 1.5,
                            color: Colors.grey.shade200,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[i]['name'],
                                  style: primaryColorHeadingStyle),
                              const SizedBox(height: 4.0),
                              Text("Upto ${data[i]['discount']}% off",
                                  style: primaryColorNormalThinTextStyle),
                            ],
                          ),
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imagebaseurlold +
                                    data[i]['productPictures'][0]
                                            ['originalname']
                                        .toString()),
                                fit: BoxFit.fitHeight,
                              ),
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
          }),
    );
  }
}
