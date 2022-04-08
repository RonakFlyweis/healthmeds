// To parse this JSON data, do
//
//     final postalCodeModel = postalCodeModelFromJson(jsonString);

import 'dart:convert';

List<PostalCodeModel> postalCodeModelFromJson(String str) =>
    List<PostalCodeModel>.from(
        json.decode(str).map((x) => PostalCodeModel.fromJson(x)));

String postalCodeModelToJson(List<PostalCodeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostalCodeModel {
  PostalCodeModel({
    this.message,
    this.status,
    this.postOffice,
  });

  String? message;
  String? status;
  List<PostOffice>? postOffice;

  factory PostalCodeModel.fromJson(Map<String, dynamic> json) =>
      PostalCodeModel(
        message: json["Message"],
        status: json["Status"],
        postOffice: List<PostOffice>.from(
            json["PostOffice"].map((x) => PostOffice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": List<dynamic>.from(postOffice!.map((x) => x.toJson())),
      };
}

class PostOffice {
  PostOffice({
    this.name,
    this.district,
    this.division,
    this.state,
    this.country,
    this.pincode,
  });

  String? name;
  String? district;
  String? division;
  String? state;
  String? country;
  String? pincode;

  factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
        name: json["Name"],
        district: json["District"],
        division: json["Division"],
        state: json["State"],
        country: json["Country"],
        pincode: json["Pincode"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "District": district,
        "Division": division,
        "State": state,
        "Country": country,
        "Pincode": pincode,
      };
}
