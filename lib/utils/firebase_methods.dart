import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void initFirebase() {
  final String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:8080'
      : 'localhost:8080';

  FirebaseFirestore.instance.settings = Settings(host: host, sslEnabled: false);
}
