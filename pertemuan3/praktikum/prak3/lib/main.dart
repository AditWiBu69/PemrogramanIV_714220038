import 'package:flutter/material.dart';
import 'package:prak3/material_app.dart';

void main() {
  runApp(const AppMaterial());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('ULBI W'),
        ),
      ),
    );
  }
}
