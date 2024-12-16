import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function onMechanicSelect;
  final Function onCustomerSelect;

  const HomeScreen(
      {Key? key,
      required this.onMechanicSelect,
      required this.onCustomerSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Araç Bakım Servisi")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => onMechanicSelect(),
                child: Text("Bakım Uzmanı Girişi")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => onCustomerSelect(),
                child: Text("Müşteri Girişi")),
          ],
        ),
      ),
    );
  }
}
