//import 'dart:io';

import 'package:artfood/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signout(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  String a = preferences.getString('role');
  print(a);

  MaterialPageRoute route = MaterialPageRoute(builder: (context) => Home());
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
