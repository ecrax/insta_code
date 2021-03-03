import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// For debug purposes only!! TODO
class CreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('posts');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'code':
                """main() {\n   print("Hello, World!"); \n} ${Random.secure().nextInt(10000000)}""",
            'highlightLanguage': "dart",
            'theme': "androidstudio",
            "user": 1,
            "timestamp": DateTime.now().toString(),
          })
          .then((value) => print("Post Added"))
          .catchError((error) => print("Failed to add post: $error"));
    }

    return Container(
      child: ElevatedButton(
        onPressed: () async {
          await addUser();
        },
        child: Text("Add data to DB"),
      ),
    );
  }
}
