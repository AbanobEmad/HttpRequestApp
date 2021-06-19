import 'package:flutter/material.dart';
import 'package:testapp/Constant.dart';

class User {
  final int index;
  final String about;
  final String name;
  final String picture;
  final String company;
  final String email;

  User({
    @required this.index,
    @required this.about,
    @required this.name,
    @required this.picture,
    @required this.company,
    @required this.email,
  });

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      index: jsonData[KIndex],
      about: jsonData[KAbout],
      name: jsonData[KName],
      picture: jsonData[kPicture],
      company: jsonData[KCompany],
      email: jsonData[KEmail],
    );
  }
}
