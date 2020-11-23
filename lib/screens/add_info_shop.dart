import 'dart:io';
import 'dart:math';

import 'package:artfood/utility/my_constant.dart';
import 'package:artfood/utility/my_style.dart';
import 'package:artfood/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfomation_shop extends StatefulWidget {
  @override
  _AddInfomation_shopState createState() => _AddInfomation_shopState();
}

class _AddInfomation_shopState extends State<AddInfomation_shop> {
  String nameshop, address, tel, urlimage;
  double lat, lng;
  File file;

  @override
  void initState() {
    super.initState();

    findlatlng();
  }

  Future<Null> findlatlng() async {
    LocationData locationdata = await findLocationData();

    setState(() {
      lat = locationdata.latitude;
      lng = locationdata.longitude;
    });

    print("lat : $lat   lng : $lng");
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<Null> chooseImage(ImageSource imagesource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imagesource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {
      print(e);
    }
  }

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
              lat == null ? Mystyle().showprogress() : showmap(),
              Mystyle().sizedBoxh(25),
              showbtn()
            ],
          ),
        ));
  }

  Widget showbtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
          color: Colors.grey.shade600,
          onPressed: () {
            if (nameshop == null ||
                nameshop.isEmpty ||
                address == null ||
                address.isEmpty ||
                tel == null ||
                tel.isEmpty) {
              normalDialog(context, 'กรุณากรอกให้ครบทุกช่อง');
            } else if (file == null) {
              normalDialog(context, 'กรุณาเลือกรูป');
            } else {
              uploadImage1();
            }
          },
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text('Save Infoation')),
    );
  }

  Future<Null> uploadImage1() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';
    String url = '${MyConstant().domain}/artfoodapi/saveShop.php';
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Respone ===>>> $value');
        urlimage = '/artfoodapi/Shop/$nameImage';
        print(urlimage);
        editusershop();
      });
    } catch (e) {}
  }

  Future<Null> editusershop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String id = preferences.getString('id');

    String url =
        '${MyConstant().domain}/artfoodapi/editDataWhereId.php?isAdd=true&id=$id&NameShop=$nameshop&Address=$address&Phone=$tel&UriImage=$urlimage&Lat=$lat&Lng=$lng';
    print(url);
    await Dio().get(url).then((value) {
      if (value.toString() == "true") {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่อีกครั้ง');
      }
    });
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('MyShop'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'ร้านของคุณ',
          snippet: 'ละติจูด = $lat ลองติจูล = $lng',
        ),
      )
    ].toSet();
  }

  Container showmap() {
    LatLng latLng = LatLng(lat, lng);
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
        markers: myMarker(),
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo, size: 35.0),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: file == null ? Image.asset('images/p1.png') : Image.file(file),
        ),
        IconButton(
            icon: Icon(Icons.add_photo_alternate, size: 35.0),
            onPressed: () => chooseImage(ImageSource.gallery)),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => nameshop = value.trim(),
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
              onChanged: (value) => address = value.trim(),
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
              onChanged: (value) => tel = value.trim(),
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


