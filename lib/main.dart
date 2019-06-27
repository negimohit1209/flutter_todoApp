import 'package:database_intro/ui/home.dart';
import 'package:database_intro/ui/notodo_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoToDo',
      home: NotodoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

