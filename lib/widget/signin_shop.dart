import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodung/models/user_shop_model.dart';
import 'package:foodung/scaffold/home.dart';
import 'package:foodung/utility/my_style.dart';
import 'package:foodung/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInShip extends StatefulWidget {
  @override
  _SignInShipState createState() => _SignInShipState();
}

class _SignInShipState extends State<SignInShip> {
  // Field
  String user, password;

  // Method
  Widget showContent() {
    return Center(
      child: Container(
        width: 250.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                labelText: 'User :',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              onChanged: (value) => password = value.trim(),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password :',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              width: 250.0,
              child: RaisedButton.icon(
                onPressed: () {
                  if (user == null ||
                      user.isEmpty ||
                      password == null ||
                      password.isEmpty) {
                    normalDialog(
                        context, 'Have Space', 'Please Fill Every Blank');
                  } else {
                    checkAuthen();
                  }
                },
                icon: Icon(Icons.fingerprint),
                label: Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/food/getUserWhereUser.php?isAdd=true&User=$user';

    try {
      Response response = await Dio().get(url);

      if (response.toString() == 'null') {
        normalDialog(context, 'User False', 'No $user in my Database');
      } else {
        var result = json.decode(response.data);
        for (var map in result) {
          UserShopModel model = UserShopModel.fromJson(map);
          if (password == model.password) {
            successLogin(model);
          } else {
            normalDialog(
                context, 'Password False', 'Please Try Agains Password False');
          }
        }
      }
    } catch (e) {}
  }

  Future<void> successLogin(UserShopModel model) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('id', model.id);
      preferences.setString('Name', model.name);
      preferences.setString('UrlShop', model.urlShop);
      preferences.setString('Lat', model.lat);
      preferences.setString('Lng', model.lng);

      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Home());
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        MyStyle().showTitle('Sign In Type Shop'),
        showContent(),
      ],
    );
  }
}
