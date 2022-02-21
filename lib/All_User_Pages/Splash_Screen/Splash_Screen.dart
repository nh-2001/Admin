import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:myproject/All_User_Pages/Onbording_Screen/Onbording_Screen.dart';

class Splash_Screen extends StatefulWidget {
  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Onboarding_Screen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                "Assets/Images/Login_Page/Login_Image.png",
                height: 450,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 50,
              ),
              Lottie.asset(
                  "Assets/Animation/Splash_Screen/89023-loading-circles.json",
                  height: 95)
            ],
          ),
        ));
  }
}
