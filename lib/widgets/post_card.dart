import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_code/models/post.dart';

import 'package:insta_code/utils/extensions.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            color: const Color(0xFFFAFAFA),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                Material(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 22,
                            backgroundImage: NetworkImage(post.user.photoUrl),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.user.name,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                post.highlightLanguage.capitalize(),
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black, // Color(0xFF878787)
                  height: 0,
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: HighlightView(
                    post.code,
                    language: post.highlightLanguage,
                    theme: post.theme,
                    padding: const EdgeInsets.all(12),
                    textStyle: GoogleFonts.firaCode(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*
Padding(
            padding: const EdgeInsets.only(top: 80.0, right: 12, left: 12),
            child: PostCard(
              code: '''main() {
  print("Hello, World!");
}
''',
              name: "Leo Kling",
              language: "Dart",
              theme: vs2015Theme,
            ),
          ),
*/
