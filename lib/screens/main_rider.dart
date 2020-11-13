import 'package:artfood/screens/home.dart';
import 'package:artfood/screens/signin.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/signout.dart';
import 'package:flutter/material.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main_Rider'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                signout(context);
              }),
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHeader(),
          // homeMenu(),
          // foodmenu(),
          // infomationmenu(),
          // signout_()
        ]),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home, size: 40),
        title: Text('รายการสั่งอาหาร ที่ลูกค้าสั่ง'),
        subtitle: Text('รายการที่ยังไม่ได้ ทำส่งลูกค้าแล้ว'),
        onTap: () => Navigator.pop(context),
      );

  ListTile foodmenu() => ListTile(
        leading: Icon(Icons.fastfood, size: 40),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการาหารของร้าน'),
        onTap: () => Navigator.pop(context),
      );

  ListTile infomationmenu() => ListTile(
        leading: Icon(Icons.info, size: 40),
        title: Text('ข้อมูลร้าน'),
        subtitle: Text('รายละเอียดข้อมูลร้าน พร้อม Edit'),
        onTap: () => Navigator.pop(context),
      );

  ListTile signout_() => ListTile(
        leading: Icon(Icons.exit_to_app, size: 40),
        title: Text('Sign Out'),
        subtitle: Text('ออกจากระบบ และ กลับไปหน้าหลัก'),
        onTap: () => signout(context),

      );

  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Mystyle().showlogo(),
      decoration: Mystyle().myBoxDecoration('r1.jpg'),
      accountName: Text('Rider'),
      accountEmail: Text('Login'),
    );
  }
}
