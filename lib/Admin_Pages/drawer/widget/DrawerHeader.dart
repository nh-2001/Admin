import 'package:flutter/material.dart';

Widget createDrawerHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Nehansh Prajapati",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("prajapatinehansh1@gmail.com")
              ],
            ),
          ],
        ),
      ]));
}
