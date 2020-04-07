import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFood extends StatefulWidget {
  @override
  _MyFoodState createState() => _MyFoodState();
}

class _MyFoodState extends State<MyFood> {
  // Field
  bool statusData = true;

  // Method
  @override
  void initState() {
    super.initState();
    readAllFood();
  }

  Future<String> getIdShip() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');
    

    return idShop;
  }

  Future<void> readAllFood() async {
    String idShop = await getIdShip();
    print('idShop ===> $idShop');
    String url =
        'https://www.androidthai.in.th/food/getFoodWhereIdShop.php?isAdd=true&idShop=$idShop';

    Response response = await Dio().get(url);
    print('response ===>> $response');
    if (response.toString() != 'null') {
      setState(() {
        statusData = false;
      });
    }
  }

  Widget showNoData() {
    return Center(
      child: Text('No Menu Food Please Add Food'),
    );
  }

  Widget showListFood() {
    return Text('ListFood');
  }

  @override
  Widget build(BuildContext context) {
    return statusData ? showNoData() : showListFood();
  }
}
