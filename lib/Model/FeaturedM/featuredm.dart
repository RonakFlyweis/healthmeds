// To parse this JSON data, do
//
//     final featuredGetM = featuredGetMFromJson(jsonString);

import 'dart:convert';

import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/api/api_response.dart';

FeaturedGetM featuredGetMFromJson(String str) => FeaturedGetM.fromJson(jsonDecode(str));

String featuredGetMToJson(FeaturedGetM data) => jsonEncode(data.toJson());

class FeaturedGetM {
  FeaturedGetM({
    this.response,
  });

  List<Response> ?response;

  factory FeaturedGetM.fromJson(Map<String, dynamic> json) => FeaturedGetM(
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response!.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    this.id,
    // this.description,
    // this.title,
    this.category,
    // this.itemCategory,
    // this.packSize,
    // this.countryOrigin,
    // this.disclaimer,
    this.brandName,
    // this.manufacturerName,
    // this.price,
    // this.discountPrice,
    // this.discountPercentage,
    // this.productForm,
    // this.productPictures,
    this.image
  });

  String ?id;
  //String ?description;
  //String ?title;
  String ?category;
  //String ?itemCategory;
  //String ?packSize;
  //String ?countryOrigin;
  //String ?disclaimer;
  String ?brandName;
  // String ?manufacturerName;
  // String ?price;
  // String ?discountPrice;
  // String ?discountPercentage;
  // String ?productForm;
  //List<ProductPicture> ?productPictures;
  String? image;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["_id"],
    // description: json["description"],
    // title: json["title"],
    category: json["category"],
    // itemCategory: json["itemCategory"],
    // packSize: json["pack_size"],
    // countryOrigin: json["country_origin"],
    // disclaimer: json["disclaimer"],
    brandName: json["brandName"],
    // manufacturerName: json["manufacturer_name"],
    // price: json["price"],
    // discountPrice: json["discount_price"],
    // discountPercentage: json["discount_percentage"],
    // productForm: json["productForm"],
    // productPictures: List<ProductPicture>.from(json["productPictures"].map((x) => ProductPicture.fromJson(x))),
    image: json["bannerImage"]
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    // "description": description,
    // "title": title,
    "category": category,
    // "itemCategory": itemCategory,
    // "pack_size": packSize,
    // "country_origin": countryOrigin,
    // "disclaimer": disclaimer,
    "brandName": brandName,
    // "manufacturer_name": manufacturerName,
    // "price": price,
    // "discount_price": discountPrice,
    // "discount_percentage": discountPercentage,
    // "productForm": productForm,
    // "productPictures": List<dynamic>.from(productPictures!.map((x) => x.toJson())),
    "bannerImage" : image
  };
}

// class ProductPicture {
//   ProductPicture({
//     this.fieldname,
//     this.originalname,
//     this.encoding,
//     this.mimetype,
//     this.destination,
//     this.filename,
//     this.path,
//     this.size,
//   });
//
//   String ?fieldname;
//   String ?originalname;
//   String ?encoding;
//   String ?mimetype;
//   String ?destination;
//   String ?filename;
//   String ?path;
//   int ?size;
//
//   factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
//     fieldname: json["fieldname"],
//     originalname: json["originalname"],
//     encoding: json["encoding"],
//     mimetype: json["mimetype"],
//     destination: json["destination"],
//     filename: json["filename"],
//     path: json["path"],
//     size: json["size"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fieldname": fieldname,
//     "originalname": originalname,
//     "encoding": encoding,
//     "mimetype": mimetype,
//     "destination": destination,
//     "filename": filename,
//     "path": path,
//     "size": size,
//   };
// }

Future<ApiResponse> getFeaturedata() async {
  ApiResponse cp = await ApiProvider()
      .getReq(endpoint:getfeaturepickurl);
  // print("==getFeaturedata=>${cp.data}");
  return cp;
}


