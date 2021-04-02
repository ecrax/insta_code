class DocObj {
  Map<dynamic, dynamic> content;

  DocObj(DocObj doc) {
    content = doc.getDocName();
  }

  Map<dynamic, dynamic> getDocName() => content;

  DocObj.setDocDetails(Map<dynamic, dynamic> doc) : content = doc;
}
