import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:newhealthapp/pages/login_signup/login.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'api_endpoint.dart';
import 'api_response.dart';

// 'Authorization': 'Bearer ${user.authToken}'
class ApiProvider {
  // -------------------------------------------Webservice Url--------------------------------------------------------------

  // static String baseUrl = '${ApiProvider.baseUrl}';
  static String baseUrl = 'http://mern.online:2002/';

// ------------------------------------------------------------------------------------------------------------------

  Future<SharedPreferences> s = SharedPreferences.getInstance();

  ///This Function is used for Auto Login.
  Future autoLogin() async {
    SharedPreferences sp = await s;
    bool b = sp.containsKey("AUTH_KEY");
    print(b);
    return b;
  }

  /// This Function is used for LogOut
  Future logout(context) async {
    final _sp = await s;
    _sp.clear();
    // _sp.setBool("DB_VISITED", true);
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (c) => Login()), (route) => false);
    Fluttertoast.showToast(msg: "Logout Successful");
    print(_sp.setBool("DB_VISITED", true));
  }

  ///This function is used for user Login via OTP
  static Future loginUser(var phone) async {
    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({"phone": phone});

    var url = baseUrl + "sendOtp";

    var r = await http.post(Uri.parse(url), body: body, headers: headers);
    return r;
  }

  //Todo Need to complete Resend function
  static Future resend(var phone) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"phone": phone});
    var url = baseUrl + "sendOtp";
    var r = await http.post(Uri.parse(url), body: body, headers: headers);
    return r;
  }

  ///for otp verification
  Future otpverify(var phone, var hash, var otp) async {
    SharedPreferences sp = await s;
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      "phone": phone,
      "hash": hash,
      "otp": otp,
    });

    var r = await http.post(Uri.parse(getotpverifyUrl),
        body: body, headers: headers);
    //var cookies = r.headers['set-cookie'];
    // final va = jsonDecode()

    //print("===Auth_Key_cookies==>${cookies}");
    //sp.setString("AUTH_KEY", "${cookies}");
    sp.setString("AUTH_KEY", jsonDecode(r.body)["loginToken"]);
    print(r.body);
    return r;
  }

  //location by postal code
  static Future postalCodeApi(var code) async {
    var url = 'https://api.postalpincode.in/pincode/$code';

    var r = await http.get(
      Uri.parse(url),
    );
    print(r.body);
    // List<PostalCodeModel> data = postalCodeModelFromJson(r.body);
    return r;
  }

  ///This Method is used for fetching data
  Future<ApiResponse> getReq(
      {required String endpoint, String query = ""}) async {
    final String url = endpoint + query;
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    //var header = {'accessToken': '$token'};
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    print(url);
    try {
      Response getReq = await get(Uri.parse(url), headers: header);
      print(getReq.request.toString() + " " + getReq.statusCode.toString());
      return ApiResponse(data: getReq.body);
    } catch (e) {
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  addPrescription({required List<String> prescriptionFilePath}) async {
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiProvider.baseUrl}prescrption'));
    for (int i = 0; i < prescriptionFilePath.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'myField', prescriptionFilePath[i]));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "prescription status code");
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      print(await response.stream.bytesToString());
      EasyLoading.showToast('Prescription Added');
    } else {
      print(response.reasonPhrase);
      EasyLoading.showToast('Some error occured try again later');
    }
  }

  static getReqBodyData({required String endpoint, String query = ""}) async {
    final String url = endpoint + query;
    // final _sp = await s;
    // var token = _sp.getString("AUTH_KEY");
    // //var header = {'accessToken': '$token'};
    var header = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${token}'
    };
    print(url);
    try {
      Response getReq = await get(Uri.parse(url), headers: header);
      print(getReq.request.toString() + " " + getReq.statusCode.toString());
      return jsonDecode(getReq.body);
    } catch (e) {
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  static getReqBodyDataAuthorized(
      {required String endpoint, String query = ""}) async {
    final String url = endpoint;
    final _sp = await SharedPreferences.getInstance();
    var token = _sp.getString("AUTH_KEY");
    print(token);
    var headers = {'Authorization': 'Bearer ${token}'};
    print(url);
    try {
      print('In try block');
      Response getReq = await http.post(Uri.parse(url), headers: headers);
      print(getReq.request.toString() + " " + getReq.statusCode.toString());
      print('got here now I will decode body');
      if (getReq.statusCode >= 200 && getReq.statusCode <= 210) {
        return jsonDecode(getReq.body);
      } else {
        return 'ronak';
      }
    } catch (e) {
      print('In catch block');
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  static getcartItems() async {
    final String url = '${ApiProvider.baseUrl}user/getCartItems';
    final _sp = await SharedPreferences.getInstance();
    var token = _sp.getString("AUTH_KEY");
    //var header = {'accessToken': '$token'};
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    print(url);
    try {
      Response getReq = await get(Uri.parse(url), headers: header);
      print(getReq.request.toString() + " " + getReq.statusCode.toString());
      return jsonDecode(getReq.body);
    } catch (e) {
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  Future<ApiResponse> postReq({required String endpoint}) async {
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    //var headers = {'Cookie': '$token'};
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      var request = http.Request('POST', Uri.parse(endpoint));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      Response getReq = await Response.fromStream(response);
      print(getReq.body);

      // if (response.statusCode == 200)
      return ApiResponse(data: getReq.body);
    } catch (e) {
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  postandGet() async {
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    //var headers = {'Cookie': '$token'};
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${ApiProvider.baseUrl}user/getCartItems'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode >= 200 && response.statusCode < 205) {
        Response r = await Response.fromStream(response);
        // print("====getcartItem====>${r.body}");
        // Fluttertoast.showToast(msg: "Successful");
        return ApiResponse(data: r.body);
      }
    } catch (e) {
      return ApiResponse(error: true);
    }
  }

  ///for update user
  Future AddUser(String name, String email) async {
    final sp = await s;
    var token = sp.getString("AUTH_KEY");
    //var headers = {'Content-Type': 'application/json', 'Cookie': '$token'};
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('POST', Uri.parse(adduserUrl));
    request.body = json.encode({"full_name": name, "email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Response r = await Response.fromStream(response);
      final value = jsonDecode(r.body);
      print(value['msg']);
      Fluttertoast.showToast(
        msg: '${value['msg']}',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Some Thing want Wrong',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  static getBanner() async {
    Uri uri = Uri.parse(getbannerurl);
    http.Response response = await http.get(uri);
    print(response);
    return response;
  }

  ///This method is used for adding product to cart
  Future addtocart(var productid, var quantity, var price) async {
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var body = {
      "cartItems": [
        {
          "product": productid.toString(),
          "quantity": quantity.toString(),
          "price": price.toString()
        }
      ]
    };

    try {
      var request = http.Request('POST', Uri.parse(getaddcarturl));
      // request.body = json.encode({
      //   "cartItems": [
      //     {"product": productid, "quantity": quantity, "price": price}
      //   ]
      // });
      request.body = jsonEncode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      Response r = await Response.fromStream(response);
      print("====================>${r.body}");

      if (response.statusCode >= 200 && response.statusCode < 205) {
        print("=========after adding ${r.statusCode}");
        print("===========after adding=========>${r.body}");
        Fluttertoast.showToast(msg: 'Product Added to Cart');
      } else {
        Response r = await Response.fromStream(response);
        print("====================>${r.body}");
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      return ApiResponse(error: true, errorMessage: e.toString());
    }
  }

  removeFromCart(String productId) async {
    final sp = await s;
    var token = sp.getString("AUTH_KEY");
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiProvider.baseUrl}user/removeCartItem'));
    request.body = json.encode({"productId": productId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      Fluttertoast.showToast(msg: 'Product removed from cart');
      print(await response.stream.bytesToString());
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong try again later');
      print(response.reasonPhrase);
    }
  }

  addOrder(String paymentType, String amount, String paymentStatus,
      String orderStatus, List productItems) async {
    final sp = await s;
    var token = sp.getString("AUTH_KEY");
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('${ApiProvider.baseUrl}addOrder'));
    request.body = jsonEncode({
      "paymentType": paymentType,
      "totalAmount": amount,
      "paymentStatus": paymentStatus,
      "orderStatus": orderStatus,
      "items": productItems
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      Fluttertoast.showToast(
          msg:
              'Order added successfully! Keep the prescription ready when order gets delivered',
          toastLength: Toast.LENGTH_LONG);
      print(await response.stream.bytesToString());
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong try again later');
      print(response.reasonPhrase);
    }
  }

  addNotification() async {
    final sp = await s;
    var token = sp.getString("AUTH_KEY");
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse('${ApiProvider.baseUrl}add-notifaction'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("notification added");
    } else {
      print("error occured in adding notification");
    }
  }

  ///This function used for searching
  Future<ApiResponse> searchByKeywordActive(String searchKeyword) async {
    ApiResponse cp = await ApiProvider().getReq(
        // endpoint: '${ApiProvider.baseUrl}filterProduct?title=',
        endpoint: '${ApiProvider.baseUrl}search-product?title=',
        query: searchKeyword);
    print("==searched=>${cp.data}");
    return cp;
  }
}

// static Future searchByKeywordActive(String searchKeyword) async {
//   http.Response response = await http.get(Uri.parse(
//       'http://mern.online:5656/filterProduct?title=$searchKeyword'));
//   String content = response.body;
//   List collection = json.decode(content);
// }

/*Future AddToCartProduct() async {
    final _sp = await s;
    var token = _sp.getString("AUTH_KEY");
    print('===========>${token}');
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'accessToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiKzkxODU4NjAxNTU1NiIsImlhdCI6MTYzODk2MjI1NSwiZXhwIjoxNjcwNTE5ODU1fQ.ROKrPWFWvL_YrziPiRRmr9pE_r9t4vW6BurHOEi3ciQ; authSession=true; refreshToken=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiKzkxODU4NjAxNTU1NiIsImlhdCI6MTYzODk2MjI1NSwiZXhwIjoxNjcwNTE5ODU1fQ.93yMakjyH_Ejef5LOT9_mKg4x2tUO-Ocs7aipZRfUwc; refreshTokenID=true'
    };
    var request = http.Request('POST', Uri.parse('https://secure-river-15887.herokuapp.com/user/cart/addtocart'));
    request.body = json.encode({
      "cartItems": [
        {
          "product": "61b09ffc62963c1edd850a9c",
          "quantity": 2,
          "price": 25023
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    Response r = await Response.fromStream(response);
    if (response.statusCode >= 200 && response.statusCode <205) {
      // print("=========after adding ${r.statusCode}");
      // print("===========after adding=========>${r.body}");
      Fluttertoast.showToast(msg: 'Product Added to Cart');
      print(await response.stream.bytesToString());
    }
    else {
      Fluttertoast.showToast(msg: 'Something went wrong');
      print(response.reasonPhrase);
    }

  }*/

//Todo this function is used for converting future response to stream response.

//   Stream get searchproduct async* {
//     print('InSide Stream');
//     yield await searchByKeywordActive();
//   }
// }

///This method is used for fetch data
//todo get request example:-in New style
/*  Future getrequest()  async {
  final _sp = await s;
  var token = _sp.getString("AUTH_KEY");
  print(token);

  var headers = {
    'accessToken':'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IkZyYW5jb3RlY2hzIiwiaWQiOjIsImlhdCI6MTYzNTAyMTg1M30._aGBmEgZmsXS441cie0YbN9czgP8qwFgvf7xLkelJTw'
    // '$token'
  };
  var request = http.Request('GET', Uri.parse('https://cash.danielaproducts.com/api/v1/Policy'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
    try{
   if (response.statusCode == 200) {
    Response r = await Response.fromStream(response);
    print(r.body);
    return ApiResponse(data: r.body);
     }
    }
  catch(e) {
    return ApiResponse(error: true, errorMessage: e.toString());
  }
 }*/

//todo for building data with futurebuilder

/*
if (s.connectionState == ConnectionState.waiting) {
return const Center(child: CircularProgressIndicator());
} else if (s.hasData &&
s.connectionState == ConnectionState.done) {
TripModel item = tripModelFromJson(s.data.data);
return
}
return const Center(
child: Text(
"OOPS! NO DATA!",
style: TextStyle(color: Colors.white),
));
 */
