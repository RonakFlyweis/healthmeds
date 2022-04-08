import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/login_signup/register.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:page_transition/page_transition.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  String hash;
  OTPScreen({required this.hash, required this.phone});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var thirdController = TextEditingController();
  var fourthController = TextEditingController();

  //todo need to remember ,focusNode for textfocusing auto
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // loadingDialog() {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       // return object of type Dialog
    //       return Dialog(
    //         elevation: 0.0,
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10.0)),
    //         child: Container(
    //           height: 150.0,
    //           padding: const EdgeInsets.all(20.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               SpinKitRing(
    //                 color: primaryColor,
    //                 size: 40.0,
    //                 lineWidth: 2.0,
    //               ),
    //               heightSpace,
    //               heightSpace,
    //               Text('Please Wait..', style: greyNormalTextStyle),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    //   //todo need to remember ,Timer for delay a process
    //   Timer(
    //       const Duration(seconds: 2),
    //       () => Navigator.pushAndRemoveUntil(
    //           context,
    //           PageTransition(
    //               type: PageTransitionType.rightToLeft, child: Register()),
    //           (route) => false)
    //       /*push(
    //             context,
    //           PageTransition(
    //               type: PageTransitionType.rightToLeft,
    //               child: Register())
    //           )*/
    //       );
    // }

    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(fixPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Verification',
                    style: primaryColorExtraBigHeadingStyle,
                  ),
                  heightSpace,
                  Text(
                    'Enter the OTP code from the phone we just sent you.',
                    style: greyNormalTextStyle,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  // OTP Box Start
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // 1 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 0.3, color: primaryColor),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLength: 1,
                          controller: firstController,
                          style: primaryColorHeadingStyle,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          },
                        ),
                      ),
                      // 1 End
                      // 2 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 0.3, color: primaryColor),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLength: 1,
                          focusNode: secondFocusNode,
                          controller: secondController,
                          style: primaryColorHeadingStyle,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(thirdFocusNode);
                          },
                        ),
                      ),
                      // 2 End
                      // 3 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 0.3, color: primaryColor),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLength: 1,
                          focusNode: thirdFocusNode,
                          controller: thirdController,
                          style: primaryColorHeadingStyle,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context)
                                .requestFocus(fourthFocusNode);
                          },
                        ),
                      ),
                      // 3 End
                      // 4 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(width: 0.3, color: primaryColor),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLength: 1,
                          focusNode: fourthFocusNode,
                          controller: fourthController,
                          style: primaryColorHeadingStyle,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {},
                        ),
                      ),
                      // 4 End
                    ],
                  ),
                  // OTP Box End
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Didn\'t receive OTP Code!',
                          style: greyNormalTextStyle),
                      widthSpace,
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: primaryColor,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Container(
                    height: 50.0,
                    width: width - (fixPadding * 2.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                    ),
                    child: TextButton(
                      child: Text(
                        'Submit',
                        style: whiteTextButtonTextStyle,
                      ),
                      onPressed: () async {
                        if (firstController.text.isNotEmpty &&
                            thirdController.text.isNotEmpty &&
                            fourthController.text.isNotEmpty &&
                            secondController.text.isNotEmpty) {
                          String otp = firstController.text +
                              secondController.text +
                              thirdController.text +
                              fourthController.text;
                          EasyLoading.show(
                              status: 'Loading..', dismissOnTap: false);

                          Response r = await ApiProvider().otpverify(
                              widget.phone, widget.hash, otp);
                          EasyLoading.dismiss();
                          var data = json.decode(r.body);
                          print("====userLogInOr = ${data['isUser']}");
                          if (r.statusCode >= 200 && r.statusCode < 210) {
                            
                            if(data['isUser'] == 1){
                              print("Usercheck 1");
                              EasyLoading.showToast(data['msg']);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: MainPage()));
                            }
                            else{
                              EasyLoading.showToast(data['msg']);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Register()));
                            }

                          } else {
                            EasyLoading.showToast(data['msg']);
                          }
                        } else {
                          EasyLoading.showError('Enter OTP!');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
