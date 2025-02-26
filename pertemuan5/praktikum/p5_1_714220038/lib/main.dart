import 'package:flutter/material.dart';
import 'package:p5_1_714220038/stateless.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        fontFamily: 'Oswald',
      ),
      home: const FirstScreen(),
    );
  }
}