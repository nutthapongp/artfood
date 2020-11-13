import 'dart:io';

import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/signout.dart';
import 'package:artfood/widget/infomatiom_shop.dart';
import 'package:artfood/widget/list_food_menu_shop.dart';
import 'package:artfood/widget/order_list_shop.dart';
import 'package:flutter/material.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main_Shop'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signout(context);
              })
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHeader(),
          homeMenu(),
          foodmenu(),
          infomationmenu(),
          signout_()
        ]),
      );

  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Mystyle().showlogo(),
      decoration: Mystyle().myBoxDecoration('f2.jpg'),
      accountName: Text('Shop'),
      accountEmail: Text('Login'),
    );
  }

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home, size: 40),
        title: Text('รายการสั่งอาหาร ที่ลูกค้าสั่ง'),
        subtitle: Text('รายการที่ยังไม่ได้ ทำส่งลูกค้าแล้ว'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodmenu() => ListTile(
        leading: Icon(Icons.fastfood, size: 40),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการาหารของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationmenu() => ListTile(
        leading: Icon(Icons.info, size: 40),
        title: Text('ข้อมูลร้าน'),
        subtitle: Text('รายละเอียดข้อมูลร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget = Infomation_shop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signout_() => ListTile(
        leading: Icon(Icons.exit_to_app, size: 40),
        title: Text('Sign Out'),
        subtitle: Text('ออกจากระบบ และ กลับไปหน้าหลัก'),
        onTap: () => signout(context),
      );
}
