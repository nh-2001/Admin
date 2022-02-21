import 'package:flutter/material.dart';
import 'package:myproject/User_Pages/drawer/navigationdrawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Account"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("This is Account page")));
  }
}
