// To parse this JSON data, do
//
//     final cartItemDetail = cartItemDetailFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

CartItemDetail cartItemDetailFromJson(String str) => CartItemDetail.fromJson(json.decode(str));

String cartItemDetailToJson(CartItemDetail data) => json.encode(data.toJson());

class CartItemDetail {
  CartItemDetail({
    this.data,
  });

  List<Datumnew> ?data;

  factory CartItemDetail.fromJson(Map<String, dynamic> json) => CartItemDetail(
    data: List<Datumnew>.from(json["data"].map((x) => Datumnew.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datumnew {
  Datumnew({
    this.product,
    this.quantity,
    this.price,
    this.id,
  });

  String ?product;
  int ?quantity;
  int ?price;
  String ?id;

  factory Datumnew.fromJson(Map<String, dynamic> json) => Datumnew(
    product: json["product"],
    quantity: json["quantity"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product,
    "quantity": quantity,
    "price": price,
    "_id": id,
  };
}

// Future<ApiResponse> getcartitemDetail() async {
//   ApiResponse cp = await ApiProvider()
//       .postReq(endpoint:getcartitemurl);
//   print("==getcartitemDetail=>${cp.data}");
//   return cp;
// }
//
//
