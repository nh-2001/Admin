import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/Login_Page/Login_Page.dart';
import 'package:myproject/User_Pages/User_Details/User_Details.dart';
import 'package:myproject/User_Pages/drawer/navigationdrawer.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_Page extends StatefulWidget {
  @override
  State<Home_Page> createState() => _Home_PageState();
}

String? MyUserID;

class _Home_PageState extends State<Home_Page> {
  _checkPermission(BuildContext context) async {
    var permission = await Permission.location.status;
    print(permission);

    if (!permission.isGranted) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      Navigator.pushNamed(context, MyRoutes.Map_Screen);
    }
  }

  void getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyUserID = prefs.getString("UserAuthID");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCredentials();
  }

  @override
  Widget build(BuildContext context) {
    print(MyUserID);

    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return new Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: navigationDrawer(),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(MyUserID).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            // ProfilePic = data["url"];
            // Firstname = data["First Name"];
            // Lastname = data["Last Name"];
            // MobNo = data["Phone no"];

            return Material(
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _checkPermission(context);
                        Navigator.pushNamed(context, MyRoutes.Map_Screen);
                      },
                      child: Text("Make trip"),
                    ),
                    Text("ID=${MyUserID}"),
                    Text("First name:${data["First Name"]}"),
                    Text("Last name:${data["Last Name"]}"),
                    // Text("Profile Pic:${data["url"]}"),
                    // Text("First name:${data["Phone no"]}"),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
