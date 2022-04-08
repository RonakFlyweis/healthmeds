// To parse this JSON data, do
//
//     final isUseCreatedcheck = isUseCreatedcheckFromJson(jsonString);

import 'dart:convert';

IsUseCreatedcheck isUseCreatedcheckFromJson(String str) => IsUseCreatedcheck.fromJson(json.decode(str));

String isUseCreatedcheckToJson(IsUseCreatedcheck data) => json.encode(data.toJson());

class IsUseCreatedcheck {
  IsUseCreatedcheck({
    this.msg,
    this.isUser,
  });

  String ?msg;
  int ?isUser;

  factory IsUseCreatedcheck.fromJson(Map<String, dynamic> json) => IsUseCreatedcheck(
    msg: json["msg"],
    isUser: json["isUser"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "isUser": isUser,
  };
}
