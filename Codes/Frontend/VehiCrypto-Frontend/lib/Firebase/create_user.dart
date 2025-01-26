import 'auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();
final nameController = TextEditingController();
final surnameController = TextEditingController();

class createUserPage extends StatefulWidget {
  @override
  _createUserPageState createState() => _createUserPageState();
}

class _createUserPageState extends State<createUserPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text(
                          'New User',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            wordSpacing: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        component1(Icons.person, 'Name...', nameController,
                            false, TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        component1(Icons.edit, 'Surname...', surnameController,
                            false, TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        component1(Icons.email_outlined, 'Email...',
                            emailController, false, TextInputType.emailAddress),
                        const SizedBox(
                          height: 10,
                        ),
                        component1(Icons.lock_outline, 'Password...',
                            passwordController, true, TextInputType.text),
                        const SizedBox(
                          height: 10,
                        ),
                        component1(
                            Icons.lock_reset_rounded,
                            'Confirm Password...',
                            confirmPasswordController,
                            true,
                            TextInputType.text),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
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
                            'Create',
                            2.58,
                            () async {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                Fluttertoast.showToast(
                                    msg: 'Passwords do not match.');
                              } else {
                                User currentUser =
                                    await myAuth.createUserWithEmail(
                                        emailController.text,
                                        passwordController.text) as User;
                                if (currentUser != null) {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                      msg:
                                          'A confirmation e-mail has been sent to your e-mail address.');
                                  Navigator.pop(context);
                                } else {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                      msg: 'This e-mail address is used.');
                                }
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
      IconData icon,
      String hintText,
      TextEditingController controller,
      bool password,
      TextInputType keybordType) {
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
          controller: controller,
          style: TextStyle(color: Colors.black.withOpacity(.9)),
          cursorColor: Colors.black,
          obscureText: password,
          keyboardType: keybordType,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
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
            child: Text(
              string,
              style: TextStyle(color: Colors.white),
            ),
          ),
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
