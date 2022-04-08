import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/testpages/newbottomnavigation.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:page_transition/page_transition.dart';

import 'otp_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _form = GlobalKey<FormState>();
  final _fullname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  getToken() async {
    
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString("AUTH_KEY");
    // print("==token get==${sp.getString("AUTH_KEY")}");
    Uri url = Uri.parse('https://secure-river-15887.herokuapp.com/addUser');
    http.Response response =await http.post(url,
    body: {
      "full_name" : _fullname.text,
      "email": _email.text
    },
    headers: {
      "Cookie" : "$token"
    }
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data); 
      Fluttertoast.showToast(msg: data['msg']);
              Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: MainPage()),
                              (route) => false);

    }
    else{
      Fluttertoast.showToast(msg: 'Something Went Wrong');
      Navigator.pop(context);
          }
    
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
            Form(
              key: _form,
              child: Padding(
                padding: EdgeInsets.all(fixPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/transparent-icon.png',
                      width: 200.0,
                      fit: BoxFit.fitWidth,
                    ),
                    heightSpace,
                    heightSpace,
                    Text('Register your account',
                        style: primaryColorHeadingStyle),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    // Full Name TextField Start
                    Container(
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
                      child: TextFormField(
                        controller: _fullname,
                        style: primaryColorHeadingStyle,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          hintText: 'Full Name',
                          hintStyle: primaryColorHeadingStyle,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Full Name TextField End
                    heightSpace,
                    heightSpace,
                    // Email Address TextField Start

                    Container(
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
                      child: TextFormField(
                        controller: _email,
                        style: primaryColorHeadingStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15.0),
                          hintText: 'Email Address',
                          hintStyle: primaryColorHeadingStyle,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    // Email Address TextField End

                    heightSpace,
                    heightSpace,
                    // Password TextField Start
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: whiteColor,
                    //     borderRadius: BorderRadius.circular(5.0),
                    //     border: Border.all(width: 0.3, color: primaryColor),
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //         blurRadius: 1.5,
                    //         spreadRadius: 1.5,
                    //         color: Colors.grey.shade200,
                    //       ),
                    //     ],
                    //   ),
                    //   child: TextFormField(
                    //     controller: _password,
                    //     style: primaryColorHeadingStyle,
                    //     keyboardType: TextInputType.text,
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.all(15.0),
                    //       hintText: 'Password',
                    //       hintStyle: primaryColorHeadingStyle,
                    //       border: InputBorder.none,
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Field can\'t be empty';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // Password TextField End
                    heightSpace,
                    heightSpace,
                    InkWell(
                      borderRadius: BorderRadius.circular(5.0),
                      onTap: () async {

                        //todo need to comment it out when status 1 is come in response from otpverify api
                        // if (_form.currentState!.validate() == false) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text('Error')));
                        // } else {
                        //   EasyLoading.show(
                        //       status: 'Loading...', dismissOnTap: false);
                          print(_fullname.text);
                          print(_email.text);
                         // ApiProvider().AddUser(
                         //      _fullname.text, _email.text);

                          // EasyLoading.dismiss();

                  getToken() ;
                          // _email.clear();
                          // _fullname.clear();
                        // }
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
