import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_code/services/auth.dart';
import 'package:insta_code/services/provider.dart';

// For debug purposes only!! TODO
class CreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _firestore = useProvider(firestoreProvider);

    final CollectionReference posts = _firestore.collection('posts');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return posts
          .add({
            "code":
                """main() {\n   print("Hello, World!"); \n} \n${Random.secure().nextInt(10000000)}""",
            "highlightLanguage": "dart",
            "theme": "androidstudio",
            "user": 1,
            "timestamp": DateTime.now().toString(),
          })
          .then((value) => print("Post Added"))
          .catchError((error) => print("Failed to add post: $error"));
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await addUser();
          },
          child: const Text("Add data to DB"),
        ),

        // TODO: Move to profile page
        ElevatedButton(
          onPressed: () async {
            await Auth().signOut();
          },
          child: const Text("Logout"),
        ),
      ],
    );
  }
}
