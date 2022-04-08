import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';

class OfferDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Offer Detail', style: appBarTitleStyle),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorNormalTextStyle),
          ),
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorNormalTextStyle),
          ),
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: primaryColorNormalTextStyle),
          ),
        ],
      ),
    );
  }
}
