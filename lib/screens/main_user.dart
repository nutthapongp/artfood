
import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/signout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String name;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name == null ? 'Main_User' : '$name login'),
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
        ]),
      );


  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Mystyle().showlogo(),
      decoration: Mystyle().myBoxDecoration('u1.jpg'),
      accountName: Text('User'),
      accountEmail: Text('Login'),
    );
  }
}
