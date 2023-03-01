import 'package:flutter/material.dart';
import 'package:my_car_wallet/pages/splash-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreeen(),
        theme: ThemeData(primarySwatch: Colors.grey));
  }
}
