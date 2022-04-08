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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Stream get searchproduct async* {
    print('InSide Stream');
    yield await ApiProvider().searchByKeywordActive(_searchKeyword.text);
  }

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
                stream: searchproduct,
                builder: (BuildContext context, AsyncSnapshot s) {
                  // print("this have data ===>${s.data.data}");
                  if (s.connectionState == ConnectionState.waiting)
                  {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (s.hasData && s.connectionState == ConnectionState.done) {
                    // print()
                    SearchedModel item = searchedModelFromJson(s.data.data);
                    return
                     Container(
                            // width: double.infinity,
                            // height: 600,
                            child: ListView.builder(
                              itemCount: item.data!.response!.length,
                              itemBuilder: (c, i) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ProductItem(
                                                id: item
                                                    .data!.response![i].id)));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width,
                                        padding:
                                            EdgeInsets.all(fixPadding * 2.0),
                                        color: whiteColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      imagebaseurl +
                                                          item
                                                              .data!
                                                              .response![i]
                                                              .productPictures![
                                                                  0]
                                                              .filename
                                                              .toString()),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            widthSpace,
                                            Container(
                                              width: width -
                                                  (fixPadding * 4.0 +
                                                      70.0 +
                                                      10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${item.data!.response![i].title} ${item.data!.response![i].packSize}',
                                                      style:
                                                          primaryColorHeadingStyle),
                                                  const SizedBox(height: 5.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          '\₹${item.data!.response![i].discountPrice}',
                                                          style: priceStyle),
                                                      widthSpace,
                                                      Text(
                                                          '\₹${item.data!.response![i].price}',
                                                          style: oldStyle),
                                                      widthSpace,
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5.0,
                                                                left: 5.0,
                                                                top: 2.0,
                                                                bottom: 2.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: redColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: Text(
                                                            '${item.data!.response![i].discountPercentage} %'
                                                                .toUpperCase(),
                                                            style:
                                                                thickWhiteTextStyle),
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
                  }
                  else if(s.connectionState == ConnectionState.none){
                    return Container(
                        child: Text(
                          'No Product Found',
                          style:
                              TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      );
                  }
                  return const Center(
                      child: Text(
                    "OOPS! NO DATA!",
                    style: TextStyle(color: Colors.black),
                  ));
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
