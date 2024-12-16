import 'auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final myAuth = Provider.of<AuthService>(context, listen: false);
      myAuth.initialize();
      await _loadEmail();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email != null) {
      emailController.text = email;
    }
  }

  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: size.width - 20,
                  height: 200,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    component1(Icons.email_outlined, 'Email...', false, true),
                    const SizedBox(
                      height: 10,
                    ),
                    component1(Icons.lock_outline, 'Password...', true, false),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 60, bottom: 5, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.pushNamed(context, '/resetPasswordPage');
                          },
                          child: const Text(
                            "Forgetten password!",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 0.8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        component2('GUEST', 2.58, () {
                          HapticFeedback.lightImpact();
                          Navigator.pushReplacementNamed(context, "/mainPage");
                        }, Colors.grey.shade300, Colors.black),
                        SizedBox(width: size.width / 20),
                        component2('LOGIN', 2.58, () async {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          if (email.isEmpty || password.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Email and password cannot be empty.');
                            return;
                          }
                          await _saveEmail(email);
                          try {
                            User? currentUser = await myAuth
                                .signInUserWithEmail(email, password);
                            if (currentUser == null) {
                              if (myAuth.userState ==
                                  UserState.noVerification) {
                                Fluttertoast.showToast(
                                    msg: 'Please confirm your e-mail address.');
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Email or password is incorrect.');
                              }
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, "/mainPage");
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: 'Email or password is incorrect!');
                          }
                        }, Color(0xFFFF4D00), Colors.white),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      component3(
                        'Create a new Account',
                        2,
                        () {
                          Navigator.pushNamed(context, '/createUserPage');
                        },
                      ),
                      SizedBox(height: size.height * .05),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 40, 151).withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: isEmail ? emailController : passwordController,
            style: TextStyle(color: Colors.black.withOpacity(.8)),
            cursorColor: Colors.black,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.black.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback,
      Color _color, Color _textColor) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: voidCallback,
        child: Container(
          height: size.width / 8,
          width: size.width / width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            string,
            style: TextStyle(color: _textColor),
          ),
        ),
      ),
    );
  }

  Widget component3(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: voidCallback,
        child: Container(
          height: size.width / 8,
          width: size.width / width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            string,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(colors: [
        Color.fromARGB(255, 135, 182, 252),
        Color.fromARGB(255, 5, 30, 172)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: const Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
