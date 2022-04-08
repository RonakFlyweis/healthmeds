import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:newhealthapp/Model/TopCategory/topcategories.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/product/product.dart';
import 'package:newhealthapp/pages/productaddtocard/productaddtocart.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/column_builder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'filter.dart';
import 'get_product_list.dart';

class ProductListAll extends StatefulWidget {
  String id;

  ProductListAll({required this.id});

  @override
  _ProductListAllState createState() => _ProductListAllState();
}

class _ProductListAllState extends State<ProductListAll> {
  int? selectedRadioSort;
  var addressadd;

  @override
  void initState() {
    super.initState();
    getAdress();
    print(widget.id);
    print(ApiProvider()
        .getReq(endpoint: getProductListurl, query: widget.id.toString()));
    selectedRadioSort = 0;
  }

  ///This Method is used to get delivering addrress of product
  Future getAdress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
    setState(() {});
  }

  setSelectedRadioSort(Object val) {
    setState(() {
      selectedRadioSort = val as int?;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Available Product', style: appBarTitleStyle),
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
              badgeContent: Text('1', style: TextStyle(color: whiteColor)),
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
/*
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          height: 70.0,
          padding:
              EdgeInsets.only(left: fixPadding * 2.0, right: fixPadding * 2.0),
          alignment: Alignment.center,
          child: Container(
            width: width - fixPadding * 4.0,
            padding: EdgeInsets.all(fixPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 1.0, color: primaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _sortModalBottomSheet(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sort, size: 22.0, color: primaryColor),
                      widthSpace,
                      Text('Sort', style: primaryColorHeadingStyle),
                    ],
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 35.0,
                  color: primaryColor,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Filter()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.filter_list, size: 22.0, color: primaryColor),
                      widthSpace,
                      Text('Filter', style: primaryColorHeadingStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
*/
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
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
                    child: Text('Change', style: primaryColorBigHeadingStyle),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder(
              future: getProductList(widget.id.toString()),
              builder: (context, AsyncSnapshot s) {
                if (s.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (s.hasData &&
                    s.connectionState == ConnectionState.done) {
                  List<ViewCategoryDetail> items =
                      viewCategoryDetailFromJson(s.data.data);
                  return Container(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (c, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ProductItem(id: items[i].id)));
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
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imagebaseurl +
                                              items[i]
                                                  .productPictures![0]
                                                  .filename
                                                  .toString()),
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    widthSpace,
                                    Container(
                                      width: width -
                                          (fixPadding * 4.0 + 70.0 + 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${items[i].title} ${items[i].packSize}',
                                              style: primaryColorHeadingStyle),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '\₹${items[i].discountPrice}',
                                                  style: priceStyle),
                                              widthSpace,
                                              Text('\₹${items[i].price}',
                                                  style: oldStyle),
                                              widthSpace,
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0,
                                                    left: 5.0,
                                                    top: 2.0,
                                                    bottom: 2.0),
                                                decoration: BoxDecoration(
                                                  color: redColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Text(
                                                    '${items[i].discountPercentage} %'
                                                        .toUpperCase(),
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
                    ),
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
          // GetProductList(),
        ],
      ),
    );
  }

  void _sortModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              Container(
                child: Container(
                  margin: EdgeInsets.all(fixPadding),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'SORT BY',
                        style: primaryColorHeadingStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Divider(
                        height: 1.0,
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: selectedRadioSort,
                        title: Text("Popularity", style: subHeadingStyle),
                        onChanged: (val) {
                          setSelectedRadioSort(val!);
                        },
                        activeColor: primaryColor,
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue: selectedRadioSort,
                        title: Text("Price -- Low to High",
                            style: subHeadingStyle),
                        onChanged: (val) {
                          print(val);
                          setSelectedRadioSort(val!);
                        },
                        activeColor: primaryColor,
                      ),
                      RadioListTile(
                        value: 3,
                        groupValue: selectedRadioSort,
                        title: Text("Price -- High to Low",
                            style: subHeadingStyle),
                        onChanged: (val) {
                          print(val);
                          setSelectedRadioSort(val!);
                        },
                        activeColor: primaryColor,
                      ),
                      RadioListTile(
                        value: 4,
                        groupValue: selectedRadioSort,
                        title: Text("Discount", style: subHeadingStyle),
                        onChanged: (val) {
                          print(val);
                          setSelectedRadioSort(val!);
                        },
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
