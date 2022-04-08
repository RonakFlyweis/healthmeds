// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';
SingleDetail singleDetailFromJson(String str) => SingleDetail.fromJson(json.decode(str));

String singleDetailToJson(SingleDetail data) => json.encode(data.toJson());

class SingleDetail {
  SingleDetail({
    this.data,
  });

  Data ?data;

  factory SingleDetail.fromJson(Map<String, dynamic> json) => SingleDetail(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.description,
    this.title,
    this.category,
    this.itemCategory,
    this.packSize,
    this.countryOrigin,
    this.disclaimer,
    this.brandName,
    this.manufacturerName,
    this.price,
    this.discountPrice,
    this.discountPercentage,
    this.productForm,
    this.productPictures,
  });

  String ?id;
  String ?description;
  String ?title;
  String ?category;
  String ?itemCategory;
  String ?packSize;
  String ?countryOrigin;
  String ?disclaimer;
  String ?brandName;
  String ?manufacturerName;
  String ?price;
  String ?discountPrice;
  String ?discountPercentage;
  String ?productForm;
  List<ProductPicture> ?productPictures;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    description: json["description"],
    title: json["title"],
    category: json["category"],
    itemCategory: json["itemCategory"],
    packSize: json["pack_size"],
    countryOrigin: json["country_origin"],
    disclaimer: json["disclaimer"],
    brandName: json["brand_name"],
    manufacturerName: json["manufacturer_name"],
    price: json["price"],
    discountPrice: json["discount_price"],
    discountPercentage: json["discount_percentage"],
    productForm: json["productForm"],
    productPictures: List<ProductPicture>.from(json["productPictures"].map((x) => ProductPicture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "title": title,
    "category": category,
    "itemCategory": itemCategory,
    "pack_size": packSize,
    "country_origin": countryOrigin,
    "disclaimer": disclaimer,
    "brand_name": brandName,
    "manufacturer_name": manufacturerName,
    "price": price,
    "discount_price": discountPrice,
    "discount_percentage": discountPercentage,
    "productForm": productForm,
    "productPictures": List<dynamic>.from(productPictures!.map((x) => x.toJson())),
  };
}

class ProductPicture {
  ProductPicture({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.destination,
    this.filename,
    this.path,
    this.size,
  });

  String ?fieldname;
  String ?originalname;
  String ?encoding;
  String ?mimetype;
  String ?destination;
  String ?filename;
  String ?path;
  int ?size;

  factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
    fieldname: json["fieldname"],
    originalname: json["originalname"],
    encoding: json["encoding"],
    mimetype: json["mimetype"],
    destination: json["destination"],
    filename: json["filename"],
    path: json["path"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "fieldname": fieldname,
    "originalname": originalname,
    "encoding": encoding,
    "mimetype": mimetype,
    "destination": destination,
    "filename": filename,
    "path": path,
    "size": size,
  };
}

Future<ApiResponse> getSingleproductDetatil(String url) async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:getSingledetailurl,query:url);
  // print("==getSingleproductDetatil=>${cp.data}");
  return cp;
}

