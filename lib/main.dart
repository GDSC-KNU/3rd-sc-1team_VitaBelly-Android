import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'pregnancy_info_screen.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Register the routes
      routes: {
        '/': (context) => MainScreen(),
        '/pregnancyInfo': (context) => PregnancyInfoScreen(),
      },
    );
  }
}
