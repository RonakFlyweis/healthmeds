import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Terms and Conditions', style: appBarTitleStyle),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: fixPadding * 2.0, right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorDescTextStyle),
          ),
          Container(
            padding: EdgeInsets.only(top: fixPadding * 2.0, right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorDescTextStyle),
          ),
          Container(
            padding: EdgeInsets.only(top: fixPadding * 2.0, right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorDescTextStyle),
          ),
          Container(
            padding: EdgeInsets.only(top: fixPadding * 2.0, right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorDescTextStyle),
          ),
          Container(
            padding: EdgeInsets.only(top: fixPadding * 2.0, right: fixPadding * 2.0, left: fixPadding * 2.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorDescTextStyle),
          ),
        ],
      ),
    );
  }
}
