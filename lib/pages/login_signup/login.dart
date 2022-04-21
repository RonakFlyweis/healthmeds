import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'otp_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TwilioPhoneVerify _twilioPhoneVerify;

  final _phone = TextEditingController();
  String phoneIsoCode = '+91';

  Future getphonenumber() async {
    Future<SharedPreferences> s = SharedPreferences.getInstance();
    SharedPreferences sp = await s;
    var addressadd = sp.getString("PHONENUMBER");
    print("======PHONENUMBER=== $addressadd");
  }

  @override
  void initState() {
    _twilioPhoneVerify = new TwilioPhoneVerify(
        accountSid: '*************************', // replace with Account SID
        authToken: 'xxxxxxxxxxxxxxxxxx', // replace with Auth Token
        serviceSid:
            'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' // replace with Service SID
        );
    // TODO: implement initState
    super.initState();
  }

  sendotp(String phone) async {
    var twilioResponse = await _twilioPhoneVerify.sendSmsCode('$phone');

    if (twilioResponse.successful ?? false) {
      //code sent
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //todo need to remember,exit from app use DoubleBackToCloseApp
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(fixPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Image.asset(
                    'assets/mainAppIcon.jpeg',
                    width: 200.0,
                    fit: BoxFit.fitWidth,
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  Text('Signin with Phone Number', style: greyHeadingStyle),
                  heightSpace,
                  heightSpace,
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          child: CountryCodePicker(
                            initialSelection: 'IN',
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            favorite: const ['+91', 'IN'],
                            alignLeft: false,
                            enabled: true,
                            hideMainText: false,
                            showFlagMain: true,
                            onChanged: (value) {
                              phoneIsoCode = value.toString();

                              print(phoneIsoCode);
                            },
                            padding: const EdgeInsets.all(16.0),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number"),
                            controller: _phone,
                            keyboardType: TextInputType.phone,
                          ),
                        )
                      ],
                    ),
                  ),
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  heightSpace,
                  InkWell(
                    borderRadius: BorderRadius.circular(5.0),
                    onTap: () async {
                      if (_phone.text.isNotEmpty) {
                        EasyLoading.show(
                            status: 'Loading...', dismissOnTap: false);
                        Response r = await ApiProvider.loginUser(_phone.text);
                        EasyLoading.dismiss();
                        print(r.statusCode);
                        if (r.statusCode == 200) {
                          var data = json.decode(r.body);
                          EasyLoading.showToast('OTP = ${data['otp']}',
                              duration: Duration(seconds: 5));
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: OTPScreen(
                                    hash: data['hash'],
                                    phone: data['phone'],
                                  )),
                              (route) => false);
                        } else {
                          EasyLoading.showToast('Something Went Wrong!');
                        }
                      } else {
                        EasyLoading.showError('Enter Phone Number!');
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: width - (fixPadding * 2.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Continue',
                        style: whiteTextButtonTextStyle,
                      ),
                    ),
                  ),
                  heightSpace,
                  Text('We\'ll send OTP for Verification.',
                      style: greyNormalTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
