import 'create_user.dart';
import 'package:flutter/material.dart';

class tempLoginPage extends StatefulWidget {
  const tempLoginPage({Key? key}) : super(key: key);

  @override
  _tempLoginPageState createState() => _tempLoginPageState();
}

class _tempLoginPageState extends State<tempLoginPage> {
  int _selectedMethod = 0;
  bool deviceConnectionStatus = false;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        toolbarHeight: 50,
        backgroundColor: Color(0xFFFF4D00),
        titleSpacing: 30,
        title: const Text(
          "Log In",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SizedBox(
          height: size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade900,
                radius: 75,
                child: const Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            customButtonLogin(),
            const SizedBox(
              height: 5,
            ),
            createNewUserButton(),
          ]),
        ),
      ),
    );
  }

  Widget customButtonLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          //primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/homePage');
        },
        child: Row(
          children: const [
            Icon(Icons.login),
            SizedBox(width: 20),
            Expanded(child: Text("Log In")),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget createNewUserButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          //primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => createUserPage()));
        },
        child: Row(
          children: const [
            Icon(Icons.person_add),
            SizedBox(width: 20),
            Expanded(child: Text("Create New User")),
            Icon(Icons.arrow_forward_ios),
          ],
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
