import 'package:flutter/material.dart';

class Mystyle {
  Color darkColor = Colors.blue.shade800;
  Color primaryColor = Colors.green.shade200;

  Widget showprogress() {
    return Center(
      child: CircularProgressIndicator(

      ),
    );
  }

  Container showlogo() {
    return Container(
      width: 120,
      child: Image.asset('images/1.png'),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: darkColor,
          fontWeight: FontWeight.bold,
        ),
      );

  SizedBox sizedBoxh(double sizeh) {
    return SizedBox(
      height: sizeh,
    );
  }

  BoxDecoration myBoxDecoration(String imagename) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/$imagename'),
          fit: BoxFit.cover // ทำให้รูปเต็มพื้นที่ของ UserAccountsDrawerHeader
          ),
    );
  }

  Widget titlecenter(BuildContext context, String text) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue.shade300,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Mystyle();
}
