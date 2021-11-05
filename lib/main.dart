import 'package:crypto/pages/market.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Market(),
    );
  }
}
