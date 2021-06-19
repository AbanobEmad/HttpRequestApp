import 'package:flutter/material.dart';
import 'package:testapp/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class ApiSevices{
  final String url="http://www.json-generator.com/api/json/get/bYKKPeXRcO?indent=2";
  Future <List<User>> GetData() async{
    var response = await http.get(url);
    List<User> users = [];
    if(response.statusCode == 200) {
      var jsData = convert.jsonDecode(response.body);
      users = (jsData as List).map((e) => User.fromJson(e)).toList();
    }
    return users;
  }
}