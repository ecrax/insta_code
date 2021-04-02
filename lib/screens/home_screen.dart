import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:insta_code/models/doc_obj.dart';
import 'package:insta_code/models/post.dart';
import 'package:insta_code/models/user.dart';
import 'package:insta_code/services/provider.dart';
import 'package:insta_code/widgets/post_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, @required this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getDocuments();
    widget.controller.addListener(() {
      if (widget.controller.position.atEdge) {
        if (widget.controller.position.pixels == 0) {
          //print('ListView scroll at top');
        } else {
          //print('ListView scroll at bottom');
          getDocumentsNext(); // Load next documents
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = context.read(authProvider);
    print(_auth.currentUser.email);

    return Container(
      child: listDocument.isNotEmpty
          ? RefreshIndicator(
              onRefresh: getDocuments,
              child: ListView.builder(
                controller: widget.controller,
                itemCount: listDocument.length,
                itemBuilder: (context, index) {
                  final Map<dynamic, dynamic> data =
                      listDocument[index].content;
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 24, right: 12, left: 12),
                    child: PostCard(
                      post: Post(
                        code: data["code"].replaceAll("\\n", "\n") as String,
                        highlightLanguage: data["highlightLanguage"] as String,
                        theme: themeMap[data["theme"]],
                        user: User(
                          name: _auth.currentUser.displayName,
                          photoUrl: _auth.currentUser.photoURL,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  List<DocObj> listDocument;
  QuerySnapshot collectionState;
  // Fetch first 15 documents
  Future<void> getDocuments() async {
    listDocument = [];
    final collection = FirebaseFirestore.instance
        .collection('posts')
        .orderBy("timestamp", descending: true)
        .limit(15);
    //print('getDocuments');
    fetchDocuments(collection);
  }

  Future<void> getDocumentsNext() async {
    // Get the last visible document
    final lastVisible = collectionState.docs[collectionState.docs.length - 1];
    //print('listDocument legnth: ${collectionState.size} last: $lastVisible');

    final collection = FirebaseFirestore.instance
        .collection('posts')
        .orderBy("timestamp", descending: true)
        .startAfterDocument(lastVisible)
        .limit(5);

    fetchDocuments(collection);
  }

  void fetchDocuments(Query collection) {
    collection.get().then((value) {
      collectionState =
          value; // store collection state to set where to start next
      value.docs.forEach((element) {
        //print('getDocuments ${element.data()}');
        setState(() {
          listDocument.add(DocObj(DocObj.setDocDetails(element.data())));
        });
      });
    });
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
