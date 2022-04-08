// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
    AddressModel({
        this.id,
        this.user,
        this.deliverTo,
        this.pincode,
        this.mobile,
        this.houseNumber,
        this.streetName,
        this.addressType,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String ?id;
    String ?user;
    String ?deliverTo;
    String ?pincode;
    String ?mobile;
    String ?houseNumber;
    String ?streetName;
    String ?addressType;
    DateTime? createdAt;
    DateTime ?updatedAt;
    int ?v;

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["_id"],
        user: json["user"],
        deliverTo: json["deliver_to"],
        pincode: json["pincode"],
        mobile: json["mobile"],
        houseNumber: json["house_number"],
        streetName: json["street_name"],
        addressType: json["address_type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "deliver_to": deliverTo,
        "pincode": pincode,
        "mobile": mobile,
        "house_number": houseNumber,
        "street_name": streetName,
        "address_type": addressType,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}
