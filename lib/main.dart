import 'package:ds_amimation/animation.dart';
import 'package:ds_amimation/isolates.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Vishanti(),
        backgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


