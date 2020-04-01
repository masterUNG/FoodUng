import 'package:flutter/material.dart';
import 'package:foodung/scaffold/home.dart';


void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ung',
      home: Home(),
    );
  }
}