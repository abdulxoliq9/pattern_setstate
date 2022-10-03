import 'package:flutter/material.dart';
import 'package:pattern_setstate/pages/creating_page.dart';
import 'package:pattern_setstate/pages/home_page.dart';
import 'package:pattern_setstate/pages/models/update_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        UpdatePage.id: (context) => UpdatePage(),
        CreatePage.id: (context) => CreatePage(),
        HomePage.id: (context) => HomePage()
      },
    );
  }
}
