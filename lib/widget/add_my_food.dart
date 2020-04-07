import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodung/utility/my_style.dart';
import 'package:foodung/utility/normal_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMyFood extends StatefulWidget {
  @override
  _AddMyFoodState createState() => _AddMyFoodState();
}

class _AddMyFoodState extends State<AddMyFood> {
  // Field
  String idShop, nameFood, detailFood, urlFood, priceFood, score = '0';
  File file;

  // Method
  @override
  void initState() {
    super.initState();
    findIdShop();
  }

  Future<void> findIdShop() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      idShop = preferences.getString('id');
    } catch (e) {}
  }

  Widget showImageFood() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/food.png') : Image.file(file),
    );
  }

  Widget nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => nameFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.fastfood),
              hintText: 'Name :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget detailForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (value) => detailFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.details),
              hintText: 'Detail :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget priceForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(keyboardType: TextInputType.number,
            onChanged: (value) => priceFood = value.trim(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.attach_money),
              hintText: 'Price :',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cameraButton() {
    return OutlineButton.icon(
      onPressed: () => chooseImage(ImageSource.camera),
      icon: Icon(Icons.add_a_photo),
      label: Text('Camera'),
    );
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker.pickImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      onPressed: () => chooseImage(ImageSource.gallery),
      icon: Icon(Icons.add_photo_alternate),
      label: Text('Gallery'),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        onPressed: () {
          if (file == null) {
            normalDialog(
                context, 'Non Choose Image', 'Please Click Camera or Gallery');
          } else if (nameFood == null ||
              nameFood.isEmpty ||
              detailFood == null ||
              detailFood.isEmpty ||
              priceFood == null ||
              priceFood.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {}
        },
        icon: Icon(Icons.fastfood),
        label: Text('Save Food'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        MyStyle().showTitle('เพิ่มรายการอาหาร'),
        MyStyle().mySizeBox(),
        showImageFood(),
        MyStyle().mySizeBox(),
        showButton(),
        MyStyle().mySizeBox(),
        nameForm(),
        MyStyle().mySizeBox(),
        detailForm(),
        MyStyle().mySizeBox(),
        priceForm(),
        MyStyle().mySizeBox(),
        saveButton(),
        MyStyle().mySizeBox(),
      ],
    );
  }
}
