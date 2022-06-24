import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newhealthapp/api/api_endpoint.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/choose_location_address/choose_location.dart';
import 'package:newhealthapp/pages/choose_location_address/model/adsressModel.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_provider.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool home = false, work = false, other = false;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController street = TextEditingController();

  callDialogBox() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              content: Row(
                // ignore: duplicate_ignore
                children: [
                  // ignore: prefer_const_constructors
                  CircularProgressIndicator(),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    width: 1.2,
                  ),
                  Text("Loading")
                ],
              ),
            ));
  }

  addAddressApi() async {
    EasyLoading.show(status: 'Adding new address..', dismissOnTap: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("AUTH_KEY");
    print(token);
    Uri url = Uri.parse('${ApiProvider.baseUrl}addAddress');
    http.Response response = await http.post(url, body: jsonEncode({
      "deliver_to": name.text.toString(),
      "pincode": pincode.text.toString(),
      "mobile": phone.text.toString(),
      "house_number": building.text.toString(),
      "street_name": street.text.toString(),
      "address_type": home == true
          ? "Home"
          : work == true
              ? "Work"
              : "Other"
    }), headers: {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json'
    });
    print(response.statusCode);
    print(name.text);
    print(token);
    print(phone.text);
    print(building.text);
    print(street.text);
    print(pincode.text);
    print(home);
    print(work);
    print(other);

    if (response.statusCode >= 200 && response.statusCode <= 210) {
      EasyLoading.dismiss();
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     PageTransition(type: PageTransitionType.rightToLeft, child: Home()),
      //     (route) => false);
      Navigator.pop(context);
      print(response.body);
      var decodedData = json.decode(response.body);

      Fluttertoast.showToast(msg: decodedData['msg']);
    } else {
      var decodeData = json.decode(response.body);
      print(decodeData);
      Navigator.pop(context);
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Add Address', style: appBarTitleStyle),
      ),
      bottomNavigationBar: Material(
        elevation: 5.0,
        child: Container(
          color: Colors.white,
          width: width,
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: () {
                  if (name.text.isNotEmpty) {
                    if (phone.text.isNotEmpty) {
                      if (pincode.text.isNotEmpty) {
                        if (building.text.isNotEmpty) {
                          if (street.text.isNotEmpty) {
                            addAddressApi();
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Please fill all the fields');
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please fill all the fields');
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Please fill all the fields');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Please fill all the fields');
                    }
                  } else {
                    Fluttertoast.showToast(msg: 'Please fill all the fields');
                  }
                },
                child: Container(
                  width: width - fixPadding * 4.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Add',
                    style: appBarTitleStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Deliver To Start
                Text('Deliver To', style: primaryColorHeadingStyle),
                heightSpace,
                Container(
                  width: width - (fixPadding * 4.0),
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 0.8, color: greyColor.withOpacity(0.6)),
                  ),
                  child: TextFormField(
                    controller: name,
                    style: searchTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'e.g. John Doe',
                      hintStyle: searchTextStyle,
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                heightSpace,
                Text('The bill will be prepared against this name',
                    style: subHeadingStyle),
                // Deliver To End
                heightSpace,
                heightSpace,
                // Mobile Number Start
                Text('Mobile Number', style: primaryColorHeadingStyle),
                heightSpace,
                Container(
                  width: width - (fixPadding * 4.0),
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 0.8, color: greyColor.withOpacity(0.6)),
                  ),
                  child: TextFormField(
                    controller: phone,
                    style: searchTextStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. +1 123456',
                      hintStyle: searchTextStyle,
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                heightSpace,
                Text('For all delivery related communication',
                    style: subHeadingStyle),
                // Mobile Number End
                heightSpace,
                heightSpace,
                // Pincode Start
                Text('PinCode', style: primaryColorHeadingStyle),
                heightSpace,
                Container(
                  width: width - (fixPadding * 24.0),
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 0.8, color: greyColor.withOpacity(0.6)),
                  ),
                  child: TextFormField(
                    controller: pincode,
                    style: searchTextStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. 10001',
                      hintStyle: searchTextStyle,
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Pincode End

                heightSpace,
                heightSpace,
                // House Number and Building Start
                Text('House Number and Building',
                    style: primaryColorHeadingStyle),
                heightSpace,
                Container(
                  width: width - (fixPadding * 4.0),
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 0.8, color: greyColor.withOpacity(0.6)),
                  ),
                  child: TextFormField(
                    controller: building,
                    style: searchTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'e.g. Oberoi Heights',
                      hintStyle: searchTextStyle,
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // House Number and Building End
                heightSpace,
                heightSpace,
                // Street Name Start
                Text('Street Name', style: primaryColorHeadingStyle),
                heightSpace,
                Container(
                  width: width - (fixPadding * 4.0),
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        width: 0.8, color: greyColor.withOpacity(0.6)),
                  ),
                  child: TextFormField(
                    controller: street,
                    style: searchTextStyle,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'e.g. Back Street',
                      hintStyle: searchTextStyle,
                      contentPadding: const EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                // Street Name End
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: fixPadding * 2.0),
                child: Text('Address Type', style: primaryColorBigHeadingStyle),
              ),
              heightSpace,
              Container(
                width: width,
                color: greyColor.withOpacity(0.2),
                padding: EdgeInsets.only(
                    top: fixPadding * 2.0, bottom: fixPadding * 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getAddressTypeTile('assets/icons/icon_9.png', 'Home'),
                    getAddressTypeTile('assets/icons/icon_10.png', 'Work'),
                    getAddressTypeTile('assets/icons/icon_11.png', 'Other'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getAddressTypeTile(String imagePath, String title) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        if (title == 'Home') {
          setState(() {
            home = true;
            work = false;
            other = false;
          });
        } else if (title == 'Work') {
          setState(() {
            home = false;
            work = true;
            other = false;
          });
        } else if (title == 'Other') {
          setState(() {
            home = false;
            work = false;
            other = true;
          });
        }
      },
      child: Container(
        width: (width - (fixPadding * 4.0)) / 3.0,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: primaryColor),
          borderRadius: BorderRadius.circular(10.0),
          color: (title == 'Home')
              ? (home)
                  ? greyColor.withOpacity(0.6)
                  : whiteColor
              : (title == 'Work')
                  ? (work)
                      ? greyColor.withOpacity(0.6)
                      : whiteColor
                  : (other)
                      ? greyColor.withOpacity(0.6)
                      : whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 25.0, fit: BoxFit.fitWidth),
            const SizedBox(width: 5.0),
            Text(title, style: primaryColorHeadingStyle),
          ],
        ),
      ),
    );
  }
}
