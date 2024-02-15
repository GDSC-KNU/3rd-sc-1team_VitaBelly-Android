import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(VitaBellyApp());
}

class VitaBellyApp extends StatelessWidget {
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBelly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
