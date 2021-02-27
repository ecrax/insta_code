import 'package:flutter/material.dart';
import 'package:insta_code/widgets/nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Code',
      theme: ThemeData(
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavBar(),
    );
  }
}
