import 'auth_services.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final emailController = TextEditingController();

class resetPasswordPage extends StatefulWidget {
  @override
  _resetPasswordPageState createState() => _resetPasswordPageState();
}

class _resetPasswordPageState extends State<resetPasswordPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    emailController.clear();
  }

  @override
  void dispose() {
    super.dispose();
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Icon(
                  Icons.key,
                  size: 150,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      component3(Icons.email, 'Email...', true),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "A verification link will be sent to your e-mail address to reset the password.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          component2(
                            'Back',
                            2.58,
                            () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: size.width / 20),
                          component2(
                            'Send',
                            2.58,
                            () async {
                              bool resetFlag = await myAuth
                                  .resetPassword(emailController.text);
                              if (resetFlag) {
                                Fluttertoast.showToast(
                                    msg:
                                        'Password recovery mail has been sent.');
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'The registered e-mail address was not found.');
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      )
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
            color: Colors.white.withOpacity(.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: emailController,
            style: TextStyle(color: Colors.white.withOpacity(.9)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
                isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component3(IconData icon, String hintText, bool isName) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: size.width / 8,
        width: size.width / 1.2,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: size.width / 30),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: emailController,
          style: TextStyle(color: Colors.black.withOpacity(.8)),
          cursorColor: Colors.black,
          keyboardType: TextInputType.text,
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
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
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
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(string,
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
