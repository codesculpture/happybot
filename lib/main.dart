import 'package:flutter/material.dart';
import 'package:test_chatbot/pages/root_page.dart';
import 'package:test_chatbot/services/authentication.dart';


void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.yellow,
          
        ),
        home: new RootPage(auth: new Auth()));
  }
}