import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newhealthapp/pages/HealthHomeScreenCheck.dart';
import 'package:newhealthapp/pages/splashscreen.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';
import 'contants/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      locale: const Locale('en', 'US'),
      title: 'HealthMeds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        fontFamily: 'Mukta',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
        ),
      ),
      home: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text('Tap back again to leave.'),
          ),
          child: HealthMedsHome(),
        ),
      ),
    );
  }
}
