import 'package:artfood/screens/main_rider.dart';
import 'package:artfood/screens/main_shop.dart';
import 'package:artfood/screens/main_user.dart';
import 'package:artfood/screens/signin.dart';
import 'package:artfood/screens/signup.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String roleuser = preferences.getString('role');

      if (roleuser != null && roleuser.isNotEmpty) {
        if (roleuser == 'User') {
          routeToservice(MainUser());
        } else if (roleuser == 'Shop') {
          routeToservice(MainShop());
        } else if (roleuser == 'Rider') {
          routeToservice(MainRider());
        } else {
          normalDialog(context, 'error');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void routeToservice(Widget myWideget) {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWideget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHeader(),
          signIn(),
          signUp(),
        ]),
      );

  ListTile signIn() {
    return ListTile(
        leading: Icon(Icons.android),
        title: Text('Sign In'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => SignIn());
          Navigator.push(context, route);
        });
  }

  ListTile signUp() {
    return ListTile(
        leading: Icon(Icons.android),
        title: Text('Sign Up'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => SignUp());
          Navigator.push(context, route);
        });
  }

  UserAccountsDrawerHeader showHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: Mystyle().showlogo(),
      decoration: Mystyle().myBoxDecoration('f1.jpg'),
      accountName: Text('Guest'),
      accountEmail: Text('Please Login'),
    );
  }
}
