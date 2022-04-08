import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/choose_location_address/model/adsressModel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_provider.dart';
import 'add_address.dart';
import 'model/postal_code_model.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  final _pincode = TextEditingController();
  bool isLoading = true;
  String _location = '';
  List<AddressModel> address = [];

  @override
  void initState() {
    super.initState();
    showAddressApi();
  }

  Future getAdress() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    var addressadd = sp.getString("ADDRESS");
    print("======Address ADDED=== $addressadd");
  }

  showAddressApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("AUTH_KEY");
    print('Token:' + token.toString());
    Uri url = Uri.parse('https://helthmade-1234.herokuapp.com/getAddress');
    http.Response response = await http.get(url, headers: {"Cookie": "$token"});
    print(response.statusCode);
    if (response.statusCode == 201) {
      address = addressModelFromJson(response.body);
      print(address);
      setState(() {
        isLoading = false;
      });
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  width: width,
                  height: height - 30.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(fixPadding * 2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150.0,
                                  child: Text('Choose your Location',
                                      style: primaryColorExtraBigHeadingStyle),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close,
                                      size: 25.0, color: primaryColor),
                                ),
                              ],
                            ),
                            heightSpace,
                            heightSpace,
                            //Todo Need to change in pincode functionality
                            //from here
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width - (fixPadding * 4.0 + 100.0),
                                  height: 43.0,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(5.0)),
                                    border: Border.all(
                                        width: 0.8, color: primaryColor),
                                  ),
                                  child: TextField(
                                    controller: _pincode,
                                    style: searchTextStyle,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter PIN Code',
                                      hintStyle: searchTextStyle,
                                      contentPadding: const EdgeInsets.all(8.0),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (_pincode.text.isNotEmpty) {
                                      EasyLoading.show(
                                          status: 'Loading...',
                                          dismissOnTap: false);
                                      http.Response r =
                                          await ApiProvider.postalCodeApi(
                                              _pincode.text);
                                      EasyLoading.dismiss();
                                      var data = json.decode(r.body);
                                      if (data[0]['Status'] == 'Success') {
                                        List<PostalCodeModel> d =
                                            postalCodeModelFromJson(r.body);
                                        EasyLoading.showToast(d
                                            .first.postOffice!.first.division!);
                                        Navigator.pop(
                                            context,
                                            d.first.postOffice!.first
                                                .division!);
                                      } else {
                                        EasyLoading.showToast(
                                            data[0]['Message']);
                                      }
                                    } else {
                                      EasyLoading.showToast(
                                          'Enter Postal code!');
                                    }
                                  },
                                  child: Container(
                                    width: 100.0,
                                    height: 43.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                              right: Radius.circular(5.0)),
                                      border: Border.all(
                                          width: 0.8, color: primaryColor),
                                    ),
                                    child: Text('Check',
                                        style: searchWhiteTextStyle),
                                  ),
                                ),
                              ],
                            ),
                            // till here
                            heightSpace,
                            heightSpace,
                            InkWell(
                              onTap: () async {
                                EasyLoading.show(
                                    status: 'Loading...', dismissOnTap: false);
                                Position position = await _determinePosition();

                                await GetAddressFromLatLong(position);
                                EasyLoading.dismiss();
                                print(position.latitude);
                                print(position.longitude);
                                print(_location);
                                Navigator.pop(context, _location);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.my_location,
                                      size: 22.0, color: primaryColor),
                                  widthSpace,
                                  Text('Select Current Location',
                                      style: primaryColorHeadingStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: fixPadding * 2.0),
                            child: Text('Saved Addresses',
                                style: primaryColorExtraBigHeadingStyle),
                          ),
                          heightSpace,
                          SizedBox(
                            height: 170.0,
                            width: width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                widthSpace,
                                widthSpace,
                                SizedBox(
                                  height: 100.0,
                                  width: (width - fixPadding * 8.0) *
                                      address.length,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: address.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                            '${address[index].streetName} ${address[index].houseNumber} ${address[index].deliverTo} ${address[index].mobile}',
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width - fixPadding * 8.0,
                                              padding: EdgeInsets.all(
                                                  fixPadding * 2.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: greyColor
                                                        .withOpacity(0.6)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 40.0,
                                                    height: 40.0,
                                                    child: Image.asset(
                                                        'assets/icons/icon_9.png',
                                                        width: 40.0,
                                                        fit: BoxFit.fitWidth),
                                                  ),
                                                  widthSpace,
                                                  widthSpace,
                                                  SizedBox(
                                                    width: width -
                                                        (fixPadding * 12.0 +
                                                            50.0 +
                                                            20.0 +
                                                            2.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            '${address[index].addressType}',
                                                            style:
                                                                primaryColorBigHeadingStyle),
                                                        Text(
                                                            '${address[index].streetName} ,H.NO:-${address[index].houseNumber}',
                                                            style:
                                                                searchTextStyle),
                                                        Text(
                                                            '${address[index].deliverTo}',
                                                            style:
                                                                searchTextStyle),
                                                        Text(
                                                            '${address[index].pincode},P.NO-${address[index].mobile}',
                                                            style:
                                                                searchTextStyle),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            widthSpace,
                                            widthSpace,
                                            widthSpace,
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                widthSpace,
                                widthSpace,
                                widthSpace,
                                InkWell(
                                  onTap: () {
                                    getAdress();
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: AddAddress()));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(0.5),
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      strokeWidth: 1.2,
                                      padding: EdgeInsets.all(fixPadding * 2.0),
                                      color: greyColor.withOpacity(0.6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40.0,
                                                height: 40.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: primaryColor,
                                                ),
                                                child: Icon(Icons.add,
                                                    size: 25.0,
                                                    color: whiteColor),
                                              ),
                                              heightSpace,
                                              SizedBox(
                                                width: 100.0,
                                                child: Text('Add New Address',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        primaryColorBigHeadingStyle),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                widthSpace,
                                widthSpace,
                              ],
                            ),
                          ),
                          Container(
                            width: width,
                            margin: EdgeInsets.all(fixPadding * 2.0),
                            padding: EdgeInsets.all(fixPadding * 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: greyColor.withOpacity(0.25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icons/icon_8.png',
                                    width: 45.0, fit: BoxFit.fitWidth),
                                widthSpace,
                                widthSpace,
                                SizedBox(
                                  width: width - (fixPadding * 8.0 + 45 + 20.0),
                                  child: Text(
                                      'Serving More than 1,000 towns and cities.',
                                      style: viewAllTextStyle),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  ///TODO get device location method
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  ///TODO method that convert postion coordinates to places
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place = placemark[0];
    _location = ' ${place.subLocality},${place.locality},${place.country}';
    setState(() {
      _location = ' ${place.subLocality},${place.locality},${place.country}';
    });
  }
}
