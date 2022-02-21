import 'package:flutter/material.dart';

class Driver_Feedback extends StatefulWidget {
  const Driver_Feedback({Key? key}) : super(key: key);

  @override
  _Driver_FeedbackState createState() => _Driver_FeedbackState();
}

class _Driver_FeedbackState extends State<Driver_Feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Deiver Feedback"),
      ),
    );
  }
}
