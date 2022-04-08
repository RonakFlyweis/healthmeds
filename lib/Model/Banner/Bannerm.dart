// To parse this JSON data, do
//
//     final bannerGetM = bannerGetMFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

BannerGetM bannerGetMFromJson(String str) => BannerGetM.fromJson(jsonDecode(str));

String bannerGetMToJson(BannerGetM data) => jsonEncode(data.toJson());

class BannerGetM {
  BannerGetM({
    this.data,
  });

  List<Datum> ?data;

  factory BannerGetM.fromJson(Map<String, dynamic> json) => BannerGetM(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.bannerImage,
  });

  String ?id;
  String ?bannerImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    bannerImage: json["bannerImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bannerImage": bannerImage,
  };
}


Future<ApiResponse> getBannerdata() async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:getbannerurl);
  return cp;
}



