class DocObj {
  var content;

  DocObj(DocObj doc) {
    this.content = doc.getDocName();
  }

  dynamic getDocName() => content;

  DocObj.setDocDetails(Map<dynamic, dynamic> doc) : content = doc;
}
