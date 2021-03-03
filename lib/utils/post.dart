import 'package:flutter/rendering.dart';
import 'package:insta_code/utils/user.dart';

class Post {
  final String code;
  final User user;
  final String highlightLanguage;
  final Map<String, TextStyle> theme;
  final String uuid;
  final DateTime timestamp;

  Post({
    this.timestamp,
    this.highlightLanguage,
    this.code,
    this.user,
    this.theme,
    this.uuid,
  });
}
