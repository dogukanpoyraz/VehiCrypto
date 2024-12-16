import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Firebase/auth_services.dart';
import "SplashScreen/splashScreen.dart";
import '/RouteGenerator/routeGenerator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
    ], child: const MyApp()));
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VehiCrypto',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: splashScreen(),
      ),
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}

/*

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMechanicSelected = false;
  bool isLoggedin = false;
  bool isCustomerSelected = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2C3E50),
          primary: Color(0xFF34495E),
          secondary: Color(0xFF3498DB),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF2C3E50),
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3498DB),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF3498DB), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2C3E50),
          primary: Color(0xFF34495E),
          secondary: Color(0xFF3498DB),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: Builder(
        builder: (context) {
          if (!isMechanicSelected && !isCustomerSelected) {
            return HomeScreen(
              onMechanicSelect: () {
                setState(() {
                  isMechanicSelected = true;
                });
              },
              onCustomerSelect: () {
                setState(() {
                  isCustomerSelected = true;
                });
              },
            );
          } else if (isMechanicSelected && !isLoggedin) {
            return LoginScreen(onLoginSuccess: () {
              setState(() {
                isLoggedin = true;
              });
            });
          } else if (isMechanicSelected && isLoggedin) {
            return MechanicFormScreen();
          } else if (isCustomerSelected) {
            return CustomerScreen();
          }
          return Container();
        },
      ),
    );
  }
}
*/
