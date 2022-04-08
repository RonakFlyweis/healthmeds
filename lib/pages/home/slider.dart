import 'package:flutter/material.dart';
import 'package:newhealthapp/Model/Banner/Bannerm.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:card_swiper/card_swiper.dart';
//
// final List<Widget> imgList = [
//   Image.asset('assets/slider/slider_1.jpg', fit: BoxFit.cover),
//   Image.asset('assets/slider/slider_2.jpg', fit: BoxFit.cover),
//   Image.asset('assets/slider/slider_3.jpg', fit: BoxFit.cover),
// ];
final List<Widget> imgLists = [];

class MainSlider extends StatelessWidget {
  List<Datum> imgLists = [];

  MainSlider(this.imgLists);

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return/* imgLists.isEmpty
              ? Center(
            child: Text(
              "NO Banner Found",
              style: TextStyle(color: Colors.black),
            ),
          )
              :*/ Image.network(
            imagebaseurl + imgLists[index].bannerImage.toString(),
            fit: BoxFit.cover,
          );
          // imgLists[index].bannerImage
        },
        autoplay: true,
        itemCount: imgLists.length < 0 ? 1 : imgLists.length,
        pagination: const SwiperPagination(),
      ),
    );
  }
}