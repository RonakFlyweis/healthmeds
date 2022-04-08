import 'package:flutter/material.dart';
import 'package:newhealthapp/api/api_provider.dart';
import 'package:newhealthapp/pages/splashscreen.dart';
import 'package:newhealthapp/widgets/bottomnavi.dart';

import 'login_signup/login.dart';


class HealthMedsHome extends StatefulWidget {
  const HealthMedsHome({Key? key}) : super(key: key);

  @override
  State<HealthMedsHome> createState() => _HealthMedsHomeState();
}

class _HealthMedsHomeState extends State<HealthMedsHome> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [false],
      future: ApiProvider().autoLogin(),
      builder: (c, s) {
        // var widget;
        if (s.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        else if (s.data != false &&
            s.connectionState == ConnectionState.done) {

          return MainPage();
          // WelcomeScreen();
        }
        return  SplashScreen();
        // return widget;
      },
    );
  }
}

