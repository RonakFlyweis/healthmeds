import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newhealthapp/Model/serachedM/serachedm.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/pages/productaddtocard/productaddtocart.dart';
import 'package:newhealthapp/pages/search/previously_purchased_item.dart';
import 'package:newhealthapp/pages/search/recently_search_item.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:page_transition/page_transition.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchKeyword = TextEditingController();
  StreamController? _streamController;
  Stream? _stream;
  Timer? _debounce;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Future fetchPost(String key) async {
  //   final response = await http.get(Uri.parse(
  //       'https://helthmade-1234.herokuapp.com/search-product?title=$key'));
  //   print(response.request);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }

  // loadResult() async {
  //   fetchPost(_searchKeyword.text.toString()).then((res) async {
  //     _postsController?.add(res);
  //     return res;
  //   });
  // }

  // showSnack() {
  //   return EasyLoading.showToast('New Content Loaded');
  // }
  //
  // Future<Null> _handleRefresh() async {
  //   fetchPost(_searchKeyword.text.toString()).then((res) async {
  //     _postsController?.add(res);
  //     showSnack();
  //     return null;
  //   });
  // }

  _search() async {
    if (_searchKeyword.text == null || _searchKeyword.text.length == 0) {
      _streamController?.add(null);
      return;
    }

    _streamController?.add("waiting");
    http.Response response = await http.get(Uri.parse(
        'https://helthmade-1234.herokuapp.com/search-product?title=${_searchKeyword.text.toString()}'));
    _streamController?.add(json.decode(response.body));
  }

  @override
  void initState() {
    _streamController = new StreamController();
    _stream = _streamController?.stream;
    super.initState();
  }

  // Stream get searchproduct async* {
  //   print('InSide Stream');
  //   yield await ApiProvider().searchByKeywordActive(_searchKeyword.text);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Container(
          width: width - 70.0,
          height: 43.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextField(
            // onChanged: (value) {
            //   // _handleRefresh();
            // },
            onChanged: (String text) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                _search();
              });
            },
            style: searchTextStyle,
            controller: _searchKeyword,
            decoration: InputDecoration(
              hintText: 'Search Medicines/healthcare products',
              hintStyle: searchTextStyle,
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.all(5.0),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: StreamBuilder(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot s) {
                  if (s.data == null) {
                    return Center(
                      child: Text("Enter a search word"),
                    );
                  }
                  if (s.data == "waiting") {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (s.connectionState == ConnectionState.waiting) {
                  //   return const Center(child: CircularProgressIndicator());
                  // } else if (s.hasData &&
                  //     s.connectionState == ConnectionState.done) {
                  // SearchedModel item = searchedModelFromJson(s.data.data);
                  return Container(
                    // width: double.infinity,
                    // height: 600,
                    child: ListView.builder(
                      // itemCount: item.data!.response!.length,
                      itemCount: s.data.length,
                      itemBuilder: (c, i) {
                        var data = s.data[i];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ProductItem(
                                      // id: item.data!.response![i].id,
                                      id: data['_id'],
                                    )));
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
                                          image: NetworkImage(
                                            imagebaseurl +
                                                data["productPictures"][0]
                                                    ["filename"],
                                            // item
                                            //     .data!
                                            //     .response![i]
                                            //     .productPictures![0]
                                            //     .filename
                                            //     .toString(),
                                          ),
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
                                              '${data["title"]} ${data["pack_size"]}',
                                              // '${item.data!.response![i].title} ${item.data!.response![i].packSize}',
                                              style: primaryColorHeadingStyle),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  '\₹${data["discount_price"]}',
                                                  // '\₹${item.data!.response![i].discountPrice}',
                                                  style: priceStyle),
                                              widthSpace,
                                              Text('\₹${data["price"]}',
                                                  // '\₹${item.data!.response![i].price}',
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
                                                    '${data["discount_percentage"]} %'
                                                        // '${item.data!.response![i].discountPercentage} %'
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
                  // : Container(
                  //     child: Text(
                  //       'No Product Found',
                  //       style:
                  //           TextStyle(fontSize: 20, color: Colors.black),
                  //     ),
                  //   );
                  // } else if (s.connectionState == ConnectionState.none) {
                  //   return Center(
                  //     child: Container(
                  //       child: Text(
                  //         'No Product Found',
                  //         style: TextStyle(fontSize: 20, color: Colors.black),
                  //       ),
                  //     ),
                  //   );
                  // }
                  // return const Center(
                  //     child: Text(
                  //   "OOPS! NO DATA!",
                  //   style: TextStyle(color: Colors.black),
                  // ));
                }),
          ),
          // Recently Search Item Start
          // RecentlySearchItem(),
          // // Recently Search Item End
          // heightSpace,
          // // Previously Purchased Item Start
          // PreviouslyPurchasedItem(),
          // Previously Purchased Item End
        ],
      ),
    );
  }
}
