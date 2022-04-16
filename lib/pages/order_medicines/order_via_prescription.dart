import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/cart_payment/cart.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/pages/order_medicines/order_medicines.dart';
import 'package:newhealthapp/pages/order_medicines/previously_bought_item.dart';
import 'package:newhealthapp/pages/search/search.dart';
import 'package:page_transition/page_transition.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api_provider.dart';

class OrderViaPrescription extends StatefulWidget {
  @override
  _OrderViaPrescriptionState createState() => _OrderViaPrescriptionState();
}

class _OrderViaPrescriptionState extends State<OrderViaPrescription> {
  final prescriptionList = [];
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _uploadPescriptionModalBottomSheet();
    });
  }

  /// Get image from camera
  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        prescriptionList.add(_image);
        _image = null;
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  /// Get image from gallery
  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        prescriptionList.add(_image);
        _image = null;
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    validPrescriptionDialogue() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            child: SizedBox(
              height: height,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50.0),
                    child: ListView(
                      children: [
                        Image.asset(
                          'assets/valid_prescription.png',
                          width: width,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50.0,
                        width: width - 80.0,
                        color: primaryColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok, Got it'.toUpperCase(),
                          style: appBarTitleStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    deletePrescriptionImageDialogue(index) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 130.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Delete prescription image?",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'No',
                            style: primaryColorTextButtonTextStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            prescriptionList.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: (MediaQuery.of(context).size.width / 3.5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Yes',
                            style: whiteTextButtonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Upload Prescription', style: appBarTitleStyle),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Search()));
            },
          ),
          IconButton(
            icon: Badge(
              badgeContent: Text('1', style: TextStyle(color: whiteColor)),
              badgeColor: redColor,
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
              final data = await ApiProvider.getcartItems();
              final cartList;
              if (data["data"].length == 0) {
                cartList = [];
              } else {
                cartList = data["data"][0]["cartItems"];
              }
              EasyLoading.dismiss();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Cart(
                        cartList: cartList,
                      )));
            },
          ),
        ],
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
                onTap: () async {
                  if (prescriptionList.length == 0) {
                    Fluttertoast.showToast(
                      msg: 'Add at least one prescription',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  } else {
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                    ApiProvider api = ApiProvider();
                    List<String> imagePath = [];
                    for (int i = 0; i < prescriptionList.length; i++) {
                      imagePath.add(prescriptionList[i].path.toString());
                    }
                    await api.addPrescription(prescriptionFilePath: imagePath);
                    EasyLoading.dismiss();
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Home()));
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
                    'Continue',
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
          heightSpace,
          Container(
            width: width,
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  child: Image.asset(
                    'assets/icons/icon_7.png',
                    width: 30.0,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                widthSpace,
                Container(
                  width: width - (fixPadding * 4.0) - 40.0,
                  child: Text('Please upload images of your prescription',
                      style: primaryColorHeadingStyle),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: InkWell(
              onTap: _uploadPescriptionModalBottomSheet,
              child: Container(
                width: width - (fixPadding * 4.0),
                padding: EdgeInsets.all(fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 0.6, color: primaryColor),
                ),
                child: Text('Upload More Prescription',
                    style: primaryColorBigHeadingStyle),
              ),
            ),
          ),
          heightSpace,
          heightSpace,
          heightSpace,
          (prescriptionList.length > 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: fixPadding * 2.0, bottom: fixPadding * 2.0),
                      child: Text('Prescriptions attached by you',
                          style: primaryColorHeadingStyle),
                    ),
                    Container(
                      width: width,
                      height: 100.0,
                      child: ListView.builder(
                        itemCount: prescriptionList.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = prescriptionList[index];
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: 80.0,
                              margin: (index == prescriptionList.length - 1)
                                  ? EdgeInsets.only(
                                      left: fixPadding * 2.0,
                                      right: fixPadding * 2.0)
                                  : EdgeInsets.only(
                                      left: fixPadding * 2.0,
                                    ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80.0,
                                    height: 100.0,
                                    child: Image.file(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    child: Container(
                                      width: 80.0,
                                      height: 100.0,
                                      color: blackColor.withOpacity(0.5),
                                      alignment: Alignment.bottomCenter,
                                      child: InkWell(
                                        onTap: () {
                                          deletePrescriptionImageDialogue(
                                              index);
                                        },
                                        child: Container(
                                          width: 80.0,
                                          padding: EdgeInsets.all(5.0),
                                          color: blackColor.withOpacity(0.8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.close,
                                                  size: 20.0,
                                                  color: whiteColor),
                                              SizedBox(width: 3.0),
                                              Text('Delete',
                                                  style: thinWhiteTextStyle),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container(),
          (prescriptionList.length > 0)
              ? Container(
                  margin: EdgeInsets.all(fixPadding * 2.0),
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6, color: primaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          border: Border.all(width: 0.3, color: primaryColor),
                          image: DecorationImage(
                            image: AssetImage('assets/doctor.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      widthSpace,
                      Container(
                        width: width - (fixPadding * 7.0 + 90.0 + 1.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Our pharmacist will call you to confirm medicines from your prescriptions by',
                                style: primaryColorDescTextStyle),
                            SizedBox(height: 5.0),
                            Text('6:19 PM Today',
                                style: primaryColorHeadingStyle),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          heightSpace,
          Padding(
            padding: EdgeInsets.only(left: fixPadding * 2.0),
            child: InkWell(
              onTap: () {
                validPrescriptionDialogue();
              },
              child: Text('What is a valid prescription?',
                  style: thinPrimaryColorTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Upload prescription Starts Here
  void _uploadPescriptionModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          double width = MediaQuery.of(context).size.width;
          return Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(fixPadding),
            child: Wrap(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.only(
                            right: fixPadding * 2.0,
                            left: fixPadding * 2.0,
                            top: fixPadding * 0.7,
                            bottom: fixPadding * 0.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Upload Prescription',
                                style: primaryColorBigHeadingStyle),
                            IconButton(
                              icon: Icon(Icons.close, color: primaryColor),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: scaffoldBgColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.only(
                          right: fixPadding * 2.0,
                          left: fixPadding * 2.0,
                          top: fixPadding * 4.0,
                          bottom: fixPadding * 4.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                getCameraImage();
                              },
                              child: Container(
                                width: (width / 2.0) - fixPadding * 4.0,
                                padding: EdgeInsets.only(
                                    top: fixPadding * 1.5,
                                    bottom: fixPadding * 1.5),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo,
                                        size: 24.0, color: primaryColor),
                                    widthSpace,
                                    Text('Camera',
                                        style: primaryColorBigHeadingStyle),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                getGalleryImage();
                              },
                              child: Container(
                                width: (width / 2.0) - fixPadding * 4.0,
                                padding: EdgeInsets.only(
                                    top: fixPadding * 1.5,
                                    bottom: fixPadding * 1.5),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo_album,
                                        size: 24.0, color: primaryColor),
                                    widthSpace,
                                    Text('Gallery',
                                        style: primaryColorBigHeadingStyle),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
// Bottom Sheet for Upload prescription Ends Here
}
