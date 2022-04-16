import 'package:flutter/material.dart';
import 'package:newhealthapp/Model/FeaturedM/featuredm.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/products_list/product_list.dart';
import 'package:page_transition/page_transition.dart';

class FeaturedBrandGrid extends StatefulWidget {
  @override
  _FeaturedBrandGridState createState() => _FeaturedBrandGridState();
}

class _FeaturedBrandGridState extends State<FeaturedBrandGrid> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      color: whiteColor,
      padding: EdgeInsets.only(top: fixPadding * 2.0, bottom: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: fixPadding * 2.5),
            child: Text(
              'Featured Brands',
              style: blackHeadingStyle,
            ),
          ),
          heightSpace,
          getItemGrid(),
        ],
      ),
    );
  }

  getItemGrid() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: 220.0,
        child: FutureBuilder(
            future: ApiProvider.getReqBodyData(endpoint: getfeaturepickurl),
            builder: (BuildContext context, AsyncSnapshot s) {
              if (s.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (s.hasData &&
                  s.connectionState == ConnectionState.done) {
                // FeaturedGetM items = featuredGetMFromJson(s.data.data);
                final data = s.data;
                print('Featured brand ----------------========' + data.length.toString());
                return ListView.builder(
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ProductList()));
                      },
                      child: Container(
                        width: 150.0,
                        margin: (index == (data.length - 1))
                            ? const EdgeInsets.only(left: 20.0, right: 20.0)
                            : const EdgeInsets.only(left: 20.0),
                        child: Container(
                          child:Stack(
                            children: [
                              Image.network(imagebaseurl+data[index]['bannerImage'].toString(),fit: BoxFit.cover,),
                              // Image.network(imagebaseurl+_item1[i].image.toString(),fit: BoxFit.cover,),
                              Positioned(
                                left: 15.0,
                                child: Text("${data[index]['brandName'].toString()}"
                                    ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          // alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //   color: whiteColor,
                          //   borderRadius: BorderRadius.circular(10.0),
                          //   border: Border.all(
                          //       width: 0.6,
                          //       color: primaryColor.withOpacity(0.6)),
                          //   image: DecorationImage(
                          //     image: NetworkImage(imagebaseurl +
                          //         items.response![index].productPictures![0]
                          //             .filename
                          //             .toString()),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
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
            }));
  }
}
