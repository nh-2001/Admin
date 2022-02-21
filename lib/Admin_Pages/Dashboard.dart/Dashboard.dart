import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Admin_Pages/drawer/navigationdrawer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String users = "0";
  String drivers = "0";
  String accepeddrivers = "0";
  String rejecteddrivers = "0";
  String? trips;
  String feedbacks = "0";
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection('Users').get().then(((value) {
      setState(() {
        users = value.size.toString();
      });

      print(users);
    }));
    FirebaseFirestore.instance
        .collection('Driver')
        .where("Approved", isEqualTo: "1")
        .get()
        .then(((value) {
      setState(() {
        drivers = value.size.toString();
      });
    }));
    FirebaseFirestore.instance
        .collection('Driver')
        .where("Approved", isEqualTo: "2")
        .get()
        .then(((value) {
      setState(() {
        accepeddrivers = value.size.toString();
      });

      print(accepeddrivers);
    }));
    FirebaseFirestore.instance
        .collection('Driver')
        .where("Approved", isEqualTo: "3")
        .get()
        .then(((value) {
      setState(() {
        rejecteddrivers = value.size.toString();
      });
    }));
    FirebaseFirestore.instance.collection('User Feedback').get().then(((value) {
      feedbacks = value.size.toString();
    }));
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          "Dashboard",
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 1,
      ),
      drawer: navigationDrawerAdmin(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 70, horizontal: 5.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            makeDashboardItem("Users", users),
            makeDashboardItem("Driver Requests", drivers),
            makeDashboardItem("Trips", "abc"),
            makeDashboardItem("Feedbacks", feedbacks),
            makeDashboardItem("Approved Drivers", accepeddrivers),
            makeDashboardItem("Rejected Drivers", rejecteddrivers),
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, String t) {
    return Card(
      elevation: 20.0,
      margin: new EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple, borderRadius: BorderRadius.circular(5)),
          child: new InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                  child: Text(
                    t,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 16.0, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
