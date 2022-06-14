import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:newhealthapp/api/api_provider.dart';

import 'package:newhealthapp/contants/constants.dart';
import 'package:newhealthapp/pages/home/home.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  final List<dynamic> cartItems;

  const Payment({Key? key, required this.cartItems}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool razorpay = false, cash = true;
  Color _colorContainer = Colors.blue;
  Future delay() async {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    });
  }

  successOrderDialog(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 170.0,
        padding: const EdgeInsets.all(20.0),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 70.0,
                width: 70.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _colorContainer,
                  borderRadius: BorderRadius.circular(35.0),
                  border: Border.all(color: primaryColor, width: 1.0),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.check,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    delay();
                    Navigator.pop(context);
                    setState(() {
                      _colorContainer = _colorContainer == Colors.red
                          ? Colors.blue
                          : Colors.red;
                    });
                    color:
                    Colors.red;
                  },
                )),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Your order has been placed!",
              style: orderPlacedTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    //   },
    // );
  }

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    double totalAmount = 0.0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      totalAmount += double.parse(widget.cartItems[i]["payablePrice"]);
    }
    print('opened Checkout');
    var options = {
      'key': 'rzp_test_fATrBVO2Ry2l55',
      'amount': totalAmount * 100,
      'name': 'V Meds',
      'description': 'Order Checkout',
      'retry': {'enabled': true, 'maxCount': 1},
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error : ' + e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    EasyLoading.showSuccess('Success: ' + response.paymentId!,
        maskType: EasyLoadingMaskType.black);
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    ApiProvider api = ApiProvider();
    int totalAmount = 0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      totalAmount += int.parse(widget.cartItems[i]["payablePrice"]);
    }
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await api.addOrder(
        'cod', totalAmount.toString(), 'pending', 'ordered', widget.cartItems);
    await api.addNotification();
    EasyLoading.dismiss();
    showDialog(
      context: context,
      builder: (BuildContext context) => successOrderDialog(context),
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainPage()),
        (Route<dynamic> route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    EasyLoading.showError(
        'Error: ' + response.code.toString() + ' - ' + response.message!,
        maskType: EasyLoadingMaskType.black);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    EasyLoading.showToast('External_Wallet: ' + response.walletName!,
        maskType: EasyLoadingMaskType.black);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Text('Choose Payment Option', style: appBarTitleStyle),
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
                  if (razorpay == true) {
                    openCheckout();
                  } else {
                    ApiProvider api = ApiProvider();
                    int totalAmount = 0;
                    for (int i = 0; i < widget.cartItems.length; i++) {
                      totalAmount +=
                          int.parse(widget.cartItems[i]["payablePrice"]);
                    }
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                    await api.addOrder('card', totalAmount.toString(),
                        'completed', 'ordered', widget.cartItems);
                    await api.addNotification();
                    EasyLoading.dismiss();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          successOrderDialog(context),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainPage()),
                        (Route<dynamic> route) => false);
                  }
                  // successOrderDialog();
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
                    'Pay',
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
          getPaymentTile(
              'Pay on Delivery', 'assets/payment_icon/cash_on_delivery.png'),
          getPaymentTile('RazorPay', 'assets/razorpay.png'),
          Container(height: fixPadding * 2.0),
        ],
      ),
    );
  }

  getPaymentTile(String title, String imgPath) {
    return InkWell(
      onTap: () {
        if (title == 'Pay on Delivery') {
          setState(() {
            razorpay = false;
            cash = true;
          });
        } else if (title == 'RazorPay') {
          setState(() {
            razorpay = true;
            cash = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            right: fixPadding * 2.0,
            left: fixPadding * 2.0,
            top: fixPadding * 2.0),
        padding: EdgeInsets.all(fixPadding * 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(
            width: 1.0,
            color: (title == 'Pay on Delivery')
                ? (cash)
                    ? primaryColor
                    : Colors.transparent
                : (razorpay)
                    ? primaryColor
                    : Colors.transparent,
          ),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70.0,
                  child:
                      Image.asset(imgPath, width: 70.0, fit: BoxFit.fitWidth),
                ),
                widthSpace,
                Text(title, style: primaryColorHeadingStyle),
              ],
            ),
            Container(
              width: 20.0,
              height: 20.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 1.5,
                  color: (title == 'Pay on Delivery')
                      ? (cash)
                          ? primaryColor
                          : Colors.transparent
                      : (razorpay)
                          ? primaryColor
                          : Colors.transparent,
                ),
              ),
              child: Container(
                width: 10.0,
                height: 10.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: (title == 'Pay on Delivery')
                      ? (cash)
                          ? primaryColor
                          : Colors.transparent
                      : (razorpay)
                          ? primaryColor
                          : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
