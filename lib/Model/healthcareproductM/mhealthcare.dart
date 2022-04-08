import 'dart:convert';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

List<Healthcaremodel> healthcaremodelFromJson(String str) =>
    List<Healthcaremodel>.from(
        json.decode(str).map((x) => Healthcaremodel.fromJson(x)));

String healthcaremodelToJson(List<Healthcaremodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Healthcaremodel {
  Healthcaremodel({
    this.id,
    this.name,
    this.categoryType,
    this.discountPercentage,
    this.image,
  });

  String? id;
  String? name;
  String? categoryType;
  String? discountPercentage;
  String? image;

  factory Healthcaremodel.fromJson(Map<String, dynamic> json) =>
      Healthcaremodel(
        id: json["_id"],
        name: json["name"],
        categoryType: json["category_type"],
        discountPercentage: json["discountPercentage"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_type": categoryType,
        "discountPercentage": discountPercentage,
        "image": image,
      };
}


Future<ApiResponse> getHealthCareProduct() async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:getHealthCarePDurl);
  print("==getHealthCarePD=>${cp.data}");
  return cp;
}