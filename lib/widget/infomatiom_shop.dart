import 'dart:io';
import 'package:artfood/screens/add_info_shop.dart';
import 'package:artfood/utility/my_constant.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Infomation_shop extends StatefulWidget {
  @override
  _Infomation_shopState createState() => _Infomation_shopState();
}

class _Infomation_shopState extends State<Infomation_shop> {
  @override
  void initState() {
    super.initState();

    getdatawithid();
  }

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

  Future<Null> getdatawithid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print(id);

    String url =
        '${MyConstant().domain}/artfoodapi/getUserWhereid.php?isAdd=true&id=$id';

    await Dio().get(url).then((value) {
      print(value);
    });
  }
}
