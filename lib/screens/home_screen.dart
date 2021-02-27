import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
import 'package:insta_code/utils/language.dart';
import 'package:insta_code/utils/post.dart';
import 'package:insta_code/utils/random_element_from_map.dart';
import 'package:insta_code/utils/user.dart';
import 'package:insta_code/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key, this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 24, right: 12, left: 12),
            child: PostCard(
              post: Post(
                code: '''
// Comment
main() {
  print("Hello, World!");
}
''',
                user: User(
                  name: "Some Person",
                ),
                highlightLanguage: highlightLanguages
                    .firstWhere((element) => element == "dart" ? true : false),
                theme: randomElementFromMap(themeMap),
              ),
            ),
          );
        },
      ),
    );
  }
}
