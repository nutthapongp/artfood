import 'dart:io';
import 'package:artfood/screens/add_info_shop.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:flutter/material.dart';

class Infomation_shop extends StatefulWidget {
  @override
  _Infomation_shopState createState() => _Infomation_shopState();
}

class _Infomation_shopState extends State<Infomation_shop> {
  void routeToAddInfo() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => AddInfomation_shop());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Mystyle().titlecenter(context, 'ยังไม่มีข้อมูล กรุณาเพิ่มข้อมูลร้าน'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => routeToAddInfo(),
        child: Icon(Icons.edit),
      ),
    );
  }
}
