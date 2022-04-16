// To parse this JSON data, do
//
//     final viewTopCategorym = viewTopCategorymFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

List<ViewTopCategorym> viewTopCategorymFromJson(String str) => List<ViewTopCategorym>.from(json.decode(str).map((x) => ViewTopCategorym.fromJson(x)));

String viewTopCategorymToJson(List<ViewTopCategorym> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewTopCategorym {
  ViewTopCategorym({
    this.id,
    // this.categoryId,
    this.name,
    //this.topCategories,
    // this.discountPercentage,
    this.image,
  });

  String ?id;
  //CategoryId ?categoryId;
  String? name;
  //String ?topCategories;
  // String ?discountPercentage;
  String ?image;

  factory ViewTopCategorym.fromJson(Map<String, dynamic> json) => ViewTopCategorym(
    id: json["_id"],
    //categoryId: CategoryId.fromJson(json["categoryId"]),
    // categoryType: json["category_type"],
    name: json["name"],
    //discountPercentage: json["discountPercentage"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    //"categoryId": categoryId!.toJson(),
    // "category_type": categoryType,
    "name": name,
    //"discountPercentage": discountPercentage,
    "image": image,
  };
}

class CategoryId {
  CategoryId({
    this.id,
    this.name,
  });

  String ?id;
  String ?name;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

Future<ApiResponse> getopcaterydata() async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:categoryitemUrl);
  // print("==gethandpickurl=>${cp.data}");
  return cp;
}