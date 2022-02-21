import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/SignUp/SignUp.dart';
import 'package:myproject/User_Pages/User_Details/BusinessUser/BusinessAdharcardUpload.dart';
import 'package:myproject/User_Pages/User_Details/BusinessUser/BusinessCertificateUpload.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class BusinessUserDocList extends StatefulWidget {
  @override
  _BusinessUserDocListState createState() => _BusinessUserDocListState();
}

class _BusinessUserDocListState extends State<BusinessUserDocList> {
  @override
  String? b;

  TextEditingController _BusinessNamecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            "Business User",
          ),
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: true,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  onChanged: (value) {
                    b = value;
                  },
                  controller: _BusinessNamecontroller,
                  decoration: InputDecoration(
                    labelText: "Business Name",
                    hintText: "ex:J PACK PVT.LTD",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Business Name can't be empty.";
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: Container(
                    height: 75,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessAdharcardUpload(),
                          ),
                        );
                      },
                      color: Theme.of(context).accentColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables

                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Aadhar Card',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 330),
                  child: Container(
                    height: 75,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessCertificateUpload(),
                          ),
                        );
                      },
                      color: Theme.of(context).accentColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables

                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(
                                height: 18,
                              ),
                              Text(
                                'Your Business Document',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, MyRoutes.homeRoute);
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(id)
                        .update({
                      'Business name': b,
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "Submit",
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
      ),
    );
  }
}
