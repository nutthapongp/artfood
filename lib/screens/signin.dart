import 'dart:convert';

import 'package:artfood/model/user_model.dart';
import 'package:artfood/screens/main_rider.dart';
import 'package:artfood/screens/main_shop.dart';
import 'package:artfood/screens/main_user.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //Field

  String username, password;

  var _controllerusername = TextEditingController();
  var _controlleruserpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Colors.white,
              Colors.grey.shade600,
            ],
            center: Alignment(0, -0.3),
            radius: 0.7,
          ),
        ),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Mystyle().showlogo(),
              Mystyle().sizedBoxh(10),
              Mystyle().showTitle('PTT DIGITAL'),
              Mystyle().sizedBoxh(10),
              userForm(),
              Mystyle().sizedBoxh(10),
              passForm(),
              Mystyle().sizedBoxh(10),
              btnlogin(),
            ],
          ),
        )),
      ),
    );
  }

  Future<Null> checkrole() async {
    String url =
        'http://192.168.1.39/artfood/getUserWhereUser.php?isAdd=true&User=$username';

    try {
      Response response = await Dio().get(url);
      print('response : $response');

      var res = json.decode(response.data);
      print('responsejsondecode : $res');

      for (var map in res) {
        Modeluser modeluser = Modeluser.fromJson(map);
        if (password == modeluser.password) {
          String type = modeluser.role;
          if (type == 'User') {
            routeToservice(MainUser(), modeluser);
          } else if (type == 'Shop') {
            routeToservice(MainShop(), modeluser);
          } else if (type == 'Rider') {
            routeToservice(MainRider(), modeluser);
          } else {
            normalDialog(context, 'error');
          }
        } else {
          normalDialog(context, 'username or password ไม่ถูกต้อง');
          _controllerusername.clear();
          _controlleruserpass.clear();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> routeToservice(Widget myWideget, Modeluser modeluser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('id', modeluser.id);
    preferences.setString('name', modeluser.name);
    preferences.setString('role', modeluser.role);

    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWideget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget btnlogin() => Container(
        child: ButtonTheme(
          minWidth: 250,
          height: 40,
          buttonColor: Colors.grey.shade400,
          child: RaisedButton(
            onPressed: () {
              if (username == null ||
                  username.isEmpty ||
                  password == null ||
                  password.isEmpty) {
                normalDialog(context, 'กรุณากรอกให้ครบ');
              } else {
                checkrole();
              }
            },
            child: Text('Login'),
          ),
        ),
      );

  Widget userForm() {
    return Container(
        width: 250,
        child: TextField(
          controller: _controllerusername,
          onChanged: (value) {
            setState(() {
              username = value.trim();
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box, color: Mystyle().primaryColor),
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontSize: 20.0,
            ),
            labelText: 'Username',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().primaryColor),
            ),
          ),
        ));
  }

  Widget passForm() {
    return Container(
        width: 250,
        child: TextField(
          controller: _controlleruserpass,
          onChanged: (value) {
            setState(() {
              password = value.trim();
            });
          },
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Mystyle().primaryColor),
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontSize: 20.0,
            ),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().darkColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Mystyle().primaryColor),
            ),
          ),
        ));
  }
}
