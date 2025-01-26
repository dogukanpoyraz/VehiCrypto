import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '/Firebase/LoginPage.dart';
import '/Firebase/create_user.dart';
import '/Firebase/resetPasswordPage.dart';
import 'package:blockchainproject/mainScaffold.dart';

class RouteGenerator {
  static Route<dynamic>? _routeOlustur(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    } else {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _routeOlustur(HomePage(), settings);
      case '/homePage':
        return _routeOlustur(HomePage(), settings);
      case '/createUserPage':
        return _routeOlustur(createUserPage(), settings);
      case '/resetPasswordPage':
        return _routeOlustur(resetPasswordPage(), settings);
      case '/mainPage':
        return _routeOlustur(MainPage(), settings);
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('404'),
            ),
            body: const Center(
              child: Text('Sayfa Bulunamadı'),
            ),
          ),
        );
    }
  }
}
