import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:insta_code/utils/doc_obj.dart';
import 'package:insta_code/utils/post.dart';
import 'package:insta_code/utils/user.dart';
import 'package:insta_code/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.controller}) : super(key: key);

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
    return Container(
      child: listDocument.length != 0
          ? RefreshIndicator(
              child: ListView.builder(
                controller: widget.controller,
                itemCount: listDocument.length,
                itemBuilder: (context, index) {
                  var data = listDocument[index].content;
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 24, right: 12, left: 12),
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
              ),
              onRefresh: getDocuments,
            )
          : CircularProgressIndicator(),
    );
  }

  List<DocObj> listDocument;
  QuerySnapshot collectionState;
  // Fetch first 15 documents
  Future<void> getDocuments() async {
    listDocument = List();
    var collection = FirebaseFirestore.instance
        .collection('posts')
        .orderBy("timestamp", descending: true)
        .limit(15);
    //print('getDocuments');
    fetchDocuments(collection);
  }

  Future<void> getDocumentsNext() async {
    // Get the last visible document
    var lastVisible = collectionState.docs[collectionState.docs.length - 1];
    //print('listDocument legnth: ${collectionState.size} last: $lastVisible');

    var collection = FirebaseFirestore.instance
        .collection('posts')
        .orderBy("timestamp", descending: true)
        .startAfterDocument(lastVisible)
        .limit(5);

    fetchDocuments(collection);
  }

  fetchDocuments(Query collection) {
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
