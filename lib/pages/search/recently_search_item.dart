import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';

class RecentlySearchItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: scaffoldBgColor,
      padding: EdgeInsets.all(fixPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recently Search Item', style: subHeadingStyle),
          heightSpace,
          Wrap(
            children: <Widget>[
              getSearchSuggestionTile('Dexlansoprazole'),
              getSearchSuggestionTile('Logidrud'),
              getSearchSuggestionTile('Ecosprin 75'),
              getSearchSuggestionTile('Dytor p'),
              getSearchSuggestionTile('Revital h'),
              getSearchSuggestionTile('Peracitamol'),
            ],
          ),
        ],
      ),
    );
  }

  getSearchSuggestionTile(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: fixPadding * 0.6, horizontal: fixPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border:
            Border.all(width: 0.5, color: primaryColor.withOpacity(0.2)),
            color: whiteColor,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

// getSearchSuggestionTile(String title) {
//   return Padding(
//     padding: EdgeInsets.only(left: 10.0),
//     child: RaisedButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//         side: BorderSide(color: primaryColor.withOpacity(0.2)),
//       ),
//       onPressed: () {},
//       color: whiteColor,
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           color: primaryColor,
//           fontWeight: FontWeight.w300,
//         ),
//       ),
//     ),
//   );
// }
}
