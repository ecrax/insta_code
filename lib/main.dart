import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_code/widgets/nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initFirebase();
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
      home: const NavBar(),
    );
  }
}

void initFirebase() {
  final String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:8080'
      : 'localhost:8080';

  FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false);
}
