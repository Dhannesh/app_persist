import 'package:app_persist/home_page.dart';
import 'package:app_persist/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Store',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home: HomePage(),
    );
  }
}




