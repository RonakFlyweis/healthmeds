import 'package:flutter/material.dart';
import 'package:newhealthapp/contants/constants.dart';

// import 'package:timeline/model/timeline_model.dart';
// import 'package:timeline/timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../api/api_endpoint.dart';

class TrackOrder extends StatefulWidget {
  final activeOrder;

  const TrackOrder({Key? key, required this.activeOrder}) : super(key: key);
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  // final List<TimelineModel> list = [
  //   const TimelineModel(id: "1", description: "21 Aug, 2020", title: "Order Accept"),
  //   const TimelineModel(id: "2", description: "21 Aug, 2020", title: "Order Packed"),
  //   const TimelineModel(id: "2", description: "22 Aug, 2020", title: "Order Dispatch"),
  //   const TimelineModel(id: "2", description: "24 Aug, 2020", title: "Order Arriving at HealthMeds Fulfilment Center")
  // ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Track Order', style: appBarTitleStyle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            color: scaffoldBgColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: whiteColor,
                  child: Image.network(
                      (imagebaseurl +
                              widget.activeOrder["items"][0]["productId"]
                                  ["productPictures"][0]["filename"])
                          .toString(),
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.fitHeight),
                ),
                widthSpace,
                SizedBox(
                  width: width - (fixPadding * 4.0 + 100.0 + 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.activeOrder["items"][0]["productId"]["title"],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: primaryColorHeadingStyle),
                      heightSpace,
                      Text('Arriving soon', style: greyNormalTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TimelineTile(
                startChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 15.0),
                      child: Text(
                        "Order Accept",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "21 Aug, 2021",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // endChild: Text("ds"),
                alignment: TimelineAlign.center,
                isFirst: true,
                indicatorStyle: const IndicatorStyle(
                  width: 15,
                  color: Colors.teal,
                ),
                // hasIndicator: false,
                beforeLineStyle: const LineStyle(
                  color: Colors.teal,
                  thickness: 4,
                ),
              ),
              TimelineTile(
                startChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        "Order Packed",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "21 Aug, 2021",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ), // endChild: Text("ds"),
                // isFirst: true,
                alignment: TimelineAlign.center,
                beforeLineStyle: const LineStyle(
                  color: Colors.teal,
                  thickness: 4,
                ),
                afterLineStyle: const LineStyle(
                  color: Colors.deepOrange,
                  thickness: 4,
                ),
                indicatorStyle: const IndicatorStyle(
                  width: 15,
                  color: Colors.teal,
                ),
              ),
              TimelineTile(
                startChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        "Order Dispatch",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "21 Aug, 2021",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ), // endChild: Text("ds"),
                alignment: TimelineAlign.center,
                // isLast: true,
                beforeLineStyle: const LineStyle(
                  color: Colors.deepOrange,
                  thickness: 4,
                ),
                indicatorStyle: const IndicatorStyle(
                  width: 15,
                  color: Colors.red,
                ),
                endChild: Container(
                  constraints: const BoxConstraints(
                    minHeight: 80,
                  ),
                  // color: Colors.lightGreenAccent,
                ),
              ),
              TimelineTile(
                startChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        "Order Arriving at HealthMeds",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Fulfilment Center",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "21 Aug, 2021",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                alignment: TimelineAlign.center,
                isLast: true,
                beforeLineStyle: const LineStyle(
                  color: Colors.deepOrange,
                  thickness: 4,
                ),
                indicatorStyle: const IndicatorStyle(
                  width: 15,
                  color: Colors.red,
                ),
                endChild: Container(
                  constraints: const BoxConstraints(
                    minHeight: 80,
                  ),
                  // color: Colors.lightGreenAccent,
                ),
              ),
            ],
          ),
        ),
      ),

      /* TimelineTile(
        alignment: TimelineAlign.start,
        beforeLineStyle: LineStyle(color:Colors.white60),

        afterLineStyle:LineStyle(color: Colors.teal) ,
        isFirst: true,
        endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 110,
          ),
          // color: Colors.teal,
        ),
        // startChild: Container(
        //   color: Colors.amberAccent,
        // ),
      )*/

      /* TimelineComponent(
        timelineList: list,
        // lineColor: Colors.red[200], // Defaults to accent color if not provided
        // backgroundColor: Colors.black87, // Defaults to white if not provided
        headingColor: primaryColor,
        // Defaults to black if not provided
        // descriptionColor: Colors.grey, // Defaults to grey if not provided
      ),
    */
    );
  }
}
