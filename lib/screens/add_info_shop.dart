import 'package:artfood/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddInfomation_shop extends StatefulWidget {
  @override
  _AddInfomation_shopState createState() => _AddInfomation_shopState();
}

class _AddInfomation_shopState extends State<AddInfomation_shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Infomation')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Mystyle().sizedBoxh(85),
              nameForm(),
              Mystyle().sizedBoxh(25),
              addressForm(),
              Mystyle().sizedBoxh(25),
              telForm(),
              Mystyle().sizedBoxh(25),
              groupImage(),
              Mystyle().sizedBoxh(25),
              showmap(),
            ],
          ),
        ));
  }

  Container showmap() {
    LatLng latLng = LatLng(13.6498678, 100.6308343);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo, size: 35.0),
          onPressed: () {},
        ),
        Container(
          width: 250.0,
          child: Image.asset('images/p1.png'),
        ),
        IconButton(
            icon: Icon(Icons.add_photo_alternate, size: 35.0),
            onPressed: () {}),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ชื่อร้านค้า',
                prefixIcon: Icon(Icons.account_box),
                border:
                    OutlineInputBorder(), // decoration InputDecoration OutlineInputBorder ทำให้ tf มันมีเส้นกรอบ
              ),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ที่อยู่ร้าน',
                prefixIcon: Icon(Icons.home),
                border:
                    OutlineInputBorder(), // decoration InputDecoration OutlineInputBorder ทำให้ tf มันมีเส้นกรอบ
              ),
            ),
          ),
        ],
      );

  Widget telForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์',
                prefixIcon: Icon(Icons.phone_iphone),
                border:
                    OutlineInputBorder(), // decoration InputDecoration OutlineInputBorder ทำให้ tf มันมีเส้นกรอบ
              ),
            ),
          ),
        ],
      );
}
