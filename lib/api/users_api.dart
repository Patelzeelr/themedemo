import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:theme_demo/ui/apicall/model/user.dart';
import 'package:http/http.dart' as http;

class UsersApi {
  static Future<List<User>> getUsersLocally(BuildContext context) async{
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');
    final body = json.decode(data);

    return body.map<User>(User.fromJson).toList();
  }
  static Future<List<User>> getUser() async{
    final url =
        'https://firebasestorage.googleapis.com/v0/b/web-johannesmilke.appspot.com/o/other%2Fvideo126%2Fusers.json?alt=media';

    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<User>(User.fromJson).toList();
  }
}