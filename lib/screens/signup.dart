import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String role, name, username, password;

  var _controllersName = TextEditingController();
  var _controllersUserName = TextEditingController();
  var _controllersPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: ListView(
          padding: EdgeInsets.all(50.0),
          children: <Widget>[
            mylogo(),
            Mystyle().sizedBoxh(10),
            showappname(),
            Mystyle().sizedBoxh(10),
            nameForm(),
            Mystyle().sizedBoxh(10),
            userForm(),
            Mystyle().sizedBoxh(10),
            passForm(),
            Mystyle().sizedBoxh(10),
            userrdo(),
            shoprdo(),
            riderrdo(),
            Mystyle().sizedBoxh(10),
            btnregister(),
          ],
        ));
  }

  Future<Null> registerThread() async {
    String url =
        'http://192.168.1.39/artfood/adduser.php?isAdd=true&name=$name&username=$username&password=$password&role=$role';

    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, "กรุณาลองสมัครใหม่อีกครั้ง");
      }
      //.then((value) {
      //   setState(() {
      //     _controllersName.clear();
      //     _controllersUserName.clear();
      //     _controllersPassword.clear();
      //     role = null;
      //     print('value : $value');

      //   });

    } catch (e) {
      print(e);
    }
  }

  Future<Null> checkUser() async {
    String url =
        'http://localhost/artfood/getUserWhereUser.php?isAdd=true&User=$username';

    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(context, "username นี้ซ้ำแล้ว กรุณากรอกใหม่");
      }
    } catch (e) {
      print(e);
    }
  }

  Widget btnregister() => Container(
        child: ButtonTheme(
          minWidth: 250,
          height: 40,
          buttonColor: Colors.blueAccent.shade100,
          child: RaisedButton(
            onPressed: () {
              print(
                  'name : $name   user : $username   password: $password   Type : $role');
              if (name == null ||
                  name.isEmpty ||
                  username == null ||
                  username.isEmpty ||
                  password == null ||
                  password.isEmpty) {
                print('object');
                normalDialog(context, "มีช่องว่างเกิดขึ้น");
              } else if (role == null) {
                normalDialog(context, "กรุณาเลือก type");
              } else {
                checkUser();
                //registerThread();
              }
            },
            child: Text('Register'),
          ),
        ),
      );

  Widget userrdo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                  value: "User",
                  groupValue: role,
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  }),
              Text('ผู้สั่งอาหาร',
                  style: TextStyle(color: Mystyle().darkColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget riderrdo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                  value: "Rider",
                  groupValue: role,
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  }),
              Text('คนส่งอาหาร', style: TextStyle(color: Mystyle().darkColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget shoprdo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250.0,
          child: Row(
            children: [
              Radio(
                  value: "Shop",
                  groupValue: role,
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  }),
              Text('เจ้าของร้านอาหาร',
                  style: TextStyle(color: Mystyle().darkColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget nameForm() {
    // wrap ด้วย row เพราะ จะทำให้ ปรับขนาดของได้
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 250,
            child: TextField(
              controller: _controllersName,
              onChanged: ((value) {
                name = value.trim();
                print('Name : ' + name);
              }),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.face, color: Mystyle().primaryColor),
                labelStyle: TextStyle(
                  color: Mystyle().darkColor,
                  fontSize: 20.0,
                ),
                labelText: 'Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Mystyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Mystyle().primaryColor),
                ),
              ),
            )),
      ],
    );
  }

  Widget userForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 250,
            child: TextField(
              controller: _controllersUserName,
              onChanged: ((value) {
                username = value;
                print('User :' + username);
              }),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.account_circle, color: Mystyle().primaryColor),
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
            )),
      ],
    );
  }

  Widget passForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 250,
            child: TextField(
              controller: _controllersPassword,
              obscureText: true,
              onChanged: ((value) {
                password = value;
                print('Pass : ' + password);
              }),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock_outline, color: Mystyle().primaryColor),
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
            )),
      ],
    );
  }

  Row showappname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Mystyle().showTitle('PTT DIGITAL'),
      ],
    );
  }

  Widget mylogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Mystyle().showlogo(),
        ],
      );
}
