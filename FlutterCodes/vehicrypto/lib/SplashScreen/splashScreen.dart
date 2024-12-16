import 'dart:async';
import 'package:blockchainproject/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:blockchainproject/screens/mechanic_form_screen.dart';
import 'package:blockchainproject/Firebase/loginPage.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/images/app_icon.png"),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(milliseconds: 2000));
      },
      nextScreen: HomePage(),
    );
  }
}
