import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:insta_code/utils/post.dart';
import 'package:insta_code/utils/user.dart';
import 'package:insta_code/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key, this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    return Container(
      child: FutureBuilder<DocumentSnapshot>(
        future: posts.doc("207acec7-76d8-4551-a057-0c83b438140b").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            return ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
                  child: PostCard(
                    post: Post(
                      code: data["code"].replaceAll("\\n", "\n"),
                      highlightLanguage: data["highlightLanguage"],
                      theme: themeMap[data["theme"]],
                      user: User(
                        name: "test",
                        photoUrl:
                            "https://sooxt98.space/content/images/size/w100/2019/01/profile.png",
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

// PostCard(
//                     post: Post(
//                       code: '''
// // Comment
// main() {
//   print("Hello, World!");
// }
// ''',
//                       user: User(
//                         name: "Some Person",
//                       ),
//                       highlightLanguage: highlightLanguages.firstWhere(
//                           (element) => element == "dart" ? true : false),
//                       theme: randomElementFromMap(themeMap),
//                     ),
//                   ),
