import 'package:flutter/material.dart';

//Future คือ การทำงานเป็นเทรดเมื่อมีการเรียกฟังก์ชั่นที่เป็น futute ทำหยุดการทำงานจอง lifecycle ทั้งหมดจนกว่าจนกว่าฟังก์ชั่นนั้นจะทำงานเสร็จ
//BuildContext  คือมันจะเป็นการขอร้อง string มานึงตัว

Future<void> normalDialog(BuildContext context, String text) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(text),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
            // OutlineButton(
            //   onPressed: () => Navigator.pop(context),
            //   child: Text('OK'),
            // ),
          ],
        ),
      ],
    ),
  );
}
