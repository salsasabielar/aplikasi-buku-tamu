import 'package:buku_tamu/huft.dart';
import 'package:buku_tamu/report.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Tamu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.blue[200],
          primaryColor: Colors.blue[250],
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      home: //LoginPage(),
      //UploadImageDemo(),
      Dashboard(),
      // Profile(),
      // DetailList(),
      // EntryForm(),
      // Report(),
    );
  }
}
