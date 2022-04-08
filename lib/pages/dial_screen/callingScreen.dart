// To parse this JSON data, do
//
//     final phoneNumbermodel = phoneNumbermodelFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

List<PhoneNumbermodel> phoneNumbermodelFromJson(String str) => List<PhoneNumbermodel>.from(json.decode(str).map((x) => PhoneNumbermodel.fromJson(x)));

String phoneNumbermodelToJson(List<PhoneNumbermodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhoneNumbermodel {
  PhoneNumbermodel({
    this.id,
    this.name,
    this.phone,
  });

  String ?id;
  String ?name;
  String ?phone;

  factory PhoneNumbermodel.fromJson(Map<String, dynamic> json) => PhoneNumbermodel(
    id: json["_id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phone": phone,
  };
}


Future<ApiResponse> getphoneNumber() async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:getphoneNumberUrl);
  // print("==gethandpickurl=>${cp.data}");
  return cp;
}