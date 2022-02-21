import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/SignUp/SignUp.dart';
import 'package:myproject/User_Pages/ReceiverInfo/ReceiverInfo.dart';
import 'package:myproject/User_Pages/TripDetails/tripDetails.dart';
import 'package:myproject/User_Pages/User_Details/User_Details.dart';
import 'package:myproject/User_Pages/WaitingScreen/WaitingScreen.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

String Driverid = "";
String? PricePerKM;
String? DriverName;
String? VehicleName;
String? VehicleNo;

class VehicleDetails extends StatelessWidget {
  String Vehicleid = "";

  String reqid = "";
  String adharcard = "";
  String businessCertificate = "";
  String? Source;
  String? Destination;
  String? Distance;
  VehicleDetails(
      {Key? key,
      required this.Vehicleid,
      this.Source,
      this.Destination,
      this.Distance})
      : super(key: key);

  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(String url) async {
      if (!await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      )) {
        throw 'Could not launch $url';
      }
    }

    CollectionReference users =
        FirebaseFirestore.instance.collection('vehicle');
    return Scaffold(
      appBar: AppBar(
        title: Text("Vehicle Detail"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(Vehicleid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            PricePerKM = data["Price"];
            DriverName = "${data["First Name"]} ${data["Last Name"]}";
            VehicleName = "${data["Vehicle Name"]}";
            VehicleNo = "${data["Vehicle No"]}";
            return Material(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialogFunc(context, data["Vehicle Image"]);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(5, 15),
                                  )
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  data["Vehicle Image"],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Driver First Name : ${data['First Name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Driver Last Name : ${data['Last Name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Vehicle Name : ${data['Vehicle Name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    Text(
                      "Vehicle No : ${data['Vehicle No']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    SizedBox(
                      height: 200,
                    ),
                    InkWell(
                      onTap: () async {
                        print(Source);
                        print(Destination);
                        print(Distance);
                        print(data['Driver Id']);
                        Driverid = data['Driver Id'];
                        await FirebaseFirestore.instance
                            .collection('Driver')
                            .doc(data['Driver Id'])
                            .collection('Request')
                            .add(
                          {
                            "Profile pic": ProfilePic,
                            "First Name": Firstname,
                            "Last Name": Lastname,
                            "Mobile Number": MobNo,
                            "Strarting Point": Source,
                            "Destinetion Point": Destination,
                            "Distance": Distance,
                            "Goods Type": goodsType,
                            "Date": date,
                            "Time": time,
                            "Receiver Mob. No.": Receiver_Mobile_No,
                            "Receiver First Name": Receiver_firstname,
                            "Receiver Last Name": Receiver_lastname,
                            "Status": "0",
                          },
                        ).then(
                          (value) {
                            print(value.id);
                            reqid = value.id;
                          },
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WaitingScreen(
                              reqid: reqid,
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: 330,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "Request",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
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

showDialogFunc(context, img) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(5),
            height: 400,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Vehicle Image",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 2,
                  width: 500,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    img,
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
