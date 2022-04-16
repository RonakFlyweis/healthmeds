import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_provider.dart';
import 'filter.dart';
import 'get_product_list.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int? selectedRadioSort;

  @override
  void initState() {
    super.initState();
    selectedRadioSort = 0;
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
            onPressed: () async{
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
                      type: PageTransitionType.rightToLeft, child: Cart(cartList: cartList,)));
            },
          ),
        ],
      ),
      // bottomNavigationBar: Material(
      //   elevation: 5.0,
      //   child: Container(
      //     color: Colors.white,
      //     width: width,
      //     height: 70.0,
      //     padding:
      //     EdgeInsets.only(left: fixPadding * 2.0, right: fixPadding * 2.0),
      //     alignment: Alignment.center,
      //     child: Container(
      //       width: width - fixPadding * 4.0,
      //       padding: EdgeInsets.all(fixPadding),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(8.0),
      //         border: Border.all(width: 1.0, color: primaryColor),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           InkWell(
      //             onTap: () {
      //               _sortModalBottomSheet(context);
      //             },
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Icon(Icons.sort, size: 22.0, color: primaryColor),
      //                 widthSpace,
      //                 Text('Sort', style: primaryColorHeadingStyle),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             width: 1.5,
      //             height: 35.0,
      //             color: primaryColor,
      //           ),
      //           InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                   context,
      //                   PageTransition(
      //                       type: PageTransitionType.rightToLeft,
      //                       child: Filter()));
      //             },
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Icon(Icons.filter_list, size: 22.0, color: primaryColor),
      //                 widthSpace,
      //                 Text('Filter', style: primaryColorHeadingStyle),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: ListView(
        children: [
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
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //         type: PageTransitionType.rightToLeft,
                    //         child: ChooseLocation()));
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
                      //getAddress();
                    });
                    print('here');
                    //print(receivedAddress);
                  },
                  child: Text('Change', style: primaryColorBigHeadingStyle),
                ),
              ],
            ),
          ),
          GetProductList(),
        ],
      ),
    );
  }

  // void _sortModalBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Wrap(
  //           children: <Widget>[
  //             Container(
  //               child: Container(
  //                 margin: EdgeInsets.all(fixPadding),
  //                 child: Column(
  //                   children: <Widget>[
  //                     Text(
  //                       'SORT BY',
  //                       style: primaryColorHeadingStyle,
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     const Divider(
  //                       height: 1.0,
  //                     ),
  //                     RadioListTile(
  //                       value: 1,
  //                       groupValue: selectedRadioSort,
  //                       title: Text("Popularity", style: subHeadingStyle),
  //                       onChanged: (val) {
  //                         setSelectedRadioSort(val!);
  //                       },
  //                       activeColor: primaryColor,
  //                     ),
  //                     RadioListTile(
  //                       value: 2,
  //                       groupValue: selectedRadioSort,
  //                       title: Text("Price -- Low to High",
  //                           style: subHeadingStyle),
  //                       onChanged: (val) {
  //                         print(val);
  //                         setSelectedRadioSort(val!);
  //                       },
  //                       activeColor: primaryColor,
  //                     ),
  //                     RadioListTile(
  //                       value: 3,
  //                       groupValue: selectedRadioSort,
  //                       title: Text("Price -- High to Low",
  //                           style: subHeadingStyle),
  //                       onChanged: (val) {
  //                         print(val);
  //                         setSelectedRadioSort(val!);
  //                       },
  //                       activeColor: primaryColor,
  //                     ),
  //                     RadioListTile(
  //                       value: 4,
  //                       groupValue: selectedRadioSort,
  //                       title: Text("Discount", style: subHeadingStyle),
  //                       onChanged: (val) {
  //                         print(val);
  //                         setSelectedRadioSort(val!);
  //                       },
  //                       activeColor: primaryColor,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }
}
