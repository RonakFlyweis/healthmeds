import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/pages/login_signup/login.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:page_transition/page_transition.dart';
import 'active_order.dart';
import 'package:fluttertoast/fluttertoast.dart';

dynamic name = "Name";
dynamic mobile = "1234567890";

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    mobileNumberController.text = mobile;
  }

  deletePrescriptionImageDialogue() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: 130.0,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Are you sure want to logout?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
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
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Cancel',
                          style: primaryColorTextButtonTextStyle,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ApiProvider().logout(context);
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 3.5),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'Logout',
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Complete Your Profile', style: appBarTitleStyle),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              name = nameController.text.toString();
              mobile = mobileNumberController.text.toString();
              Fluttertoast.showToast(msg: "Saved Successful");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) =>  Home())
              // );
            },
            child: Text(
              'Save',
              style: whiteTextButtonTextStyle,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: width,
            color: whiteColor,
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width - (fixPadding * 4.0),
                  child: TextField(
                    controller: nameController,
                    autocorrect: true,
                    style: searchTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: subHeadingStyle,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.9),
                      ),
                    ),
                  ),
                ),
                heightSpace,
                heightSpace,
                SizedBox(
                  width: width - (fixPadding * 4.0),
                  child: TextField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    style: searchTextStyle,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: subHeadingStyle,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 0.6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor, width: 0.9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              EasyLoading.show();
              final body = await ApiProvider.getReqBodyDataAuthorized(
                  endpoint:
                      '${ApiProvider.baseUrl}getPreviouslyBoughtItem');
              EasyLoading.dismiss();
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ActiveOrder(
                        activeOrder: body['data'][0],
                      )));
            },
            child: Container(
              width: width,
              margin: EdgeInsets.all(fixPadding * 2.0),
              padding: EdgeInsets.all(fixPadding * 1.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: primaryColor,
              ),
              child: Text('Active Orders', style: whiteColorHeadingStyle),
            ),
          ),
          InkWell(
            onTap: () {
              deletePrescriptionImageDialogue();
            },
            child: Container(
              width: width,
              margin: EdgeInsets.only(
                  right: fixPadding * 2.0,
                  left: fixPadding * 2.0,
                  bottom: fixPadding * 2.0),
              padding: EdgeInsets.all(fixPadding * 1.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.3, color: primaryColor),
                color: primaryColor,
              ),
              child: Text('Logout', style: whiteColorHeadingStyle),
            ),
          ),
        ],
      ),
    );
  }
}
