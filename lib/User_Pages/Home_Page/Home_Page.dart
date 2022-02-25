import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/Login_Page/Login_Page.dart';
import 'package:myproject/User_Pages/User_Details/User_Details.dart';
import 'package:myproject/User_Pages/drawer/navigationdrawer.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  final List<String> imagelist = [
    "https://images.unsplash.com/photo-1519003722824-194d4455a60c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dHJhbnNwb3J0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://thumbs.dreamstime.com/b/business-logistics-concept-plane-truck-train-logistic-import-export-background-business-logistics-concept-105863390.jpg",
    "https://wallpaperaccess.com/full/4180857.jpg",
    "https://images.unsplash.com/photo-1559297434-fae8a1916a79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dHJhbnNwb3J0fGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    "https://wallpaperaccess.com/full/1898725.jpg",
    "https://images.unsplash.com/photo-1446694292248-2c2a7e575b1b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
  ];

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
        title: Text(
          "E-Transportation",
        ),
        toolbarHeight: 70,
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            //backgroundImage: NetworkImage(data["url"]),
                            radius: 27,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Text(
                          //   "${data["First Name"]} ${data["Last Name"]}"
                          //       .toUpperCase(),
                          //   textAlign: TextAlign.start,
                          //   style: TextStyle(
                          //     fontSize: 17,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Center(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                        ),
                        items: imagelist
                            .map(
                              (e) => ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Image.network(
                                      e,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      await _checkPermission(context);
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Make Trip",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      )),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
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
