import 'dart:convert';

import 'package:artfood/model/user_model.dart';
import 'package:artfood/utility/my_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Text('แสดงรายการอาหาร');
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
