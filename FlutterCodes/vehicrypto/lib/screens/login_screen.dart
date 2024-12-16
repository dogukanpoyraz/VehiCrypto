import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function onLoginSuccess;
  const LoginScreen({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bakım Uzmanı Girişi")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Kullanıcı Adı"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Şifre"),
            ),
            SizedBox(height: 20),
            if (error != null)
              Text(error!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
                onPressed: () {
                  if (_usernameController.text == "admin" &&
                      _passwordController.text == "admin") {
                    widget.onLoginSuccess();
                  } else {
                    setState(() {
                      error = "Yanlış kullanıcı adı veya şifre";
                    });
                  }
                },
                child: Text("Giriş"))
          ],
        ),
      ),
    );
  }
}
