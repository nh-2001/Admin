import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:myproject/User_Pages/ReceiverInfo/ReceiverInfo.dart';
import 'package:myproject/User_Pages/drawer/navigationdrawer.dart';
import 'package:myproject/Utils/routes.dart';

class TripDetails extends StatefulWidget {
  String? Source;
  String? Destination;
  String? Distance;
  TripDetails({Key? key, this.Source, this.Destination, this.Distance})
      : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

String goodsType = "";
String? date, time;

class _TripDetailsState extends State<TripDetails> {
  // create TimeOfDay variable
  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = TextEditingController();
  TextEditingController _timecontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // show time picker method
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((val) {
      setState(() {
        print(val);
        _timeOfDay = val!;
        _timecontroller.text = _timeOfDay.format(context).toString();
      });
    });
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(3000))
        .then((value) {
      setState(() {
        print(value!.day.toString());
        _date = value;
        _datecontroller.text = _date.day.toString() +
            "-" +
            _date.month.toString() +
            "-" +
            _date.year.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 30),
                  child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSelectedItems: true,
                      items: [
                        "Cloths",
                        "Food",
                        "Cars",
                        "Flowers",
                      ],
                      label: "Type of goods",
                      hint: "country in menu mode",
                      popupItemDisabled: (String s) => s.startsWith('I'),
                      onChanged: (data) {
                        goodsType = data!;
                      },
                      selectedItem: "Cloths"),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: TextFormField(
                    readOnly: true,
                    onTap: _showDatePicker,
                    controller: _datecontroller,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: InkWell(
                        child: Icon(Icons.date_range),
                        onTap: _showDatePicker,
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Date can't be empty.";
                      }
                      null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: TextFormField(
                    onTap: _showTimePicker,
                    readOnly: true,
                    controller: _timecontroller,
                    decoration: InputDecoration(
                      labelText: "Time",
                      suffixIcon: InkWell(
                        child: Icon(Icons.watch_later_rounded),
                        onTap: _showTimePicker,
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Time can't be empty.";
                      }
                      null;
                    },
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        time = _timecontroller.text;
                        date = _datecontroller.text;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiverInfo(
                              Source: widget.Source,
                              Destination: widget.Destination,
                              Distance: widget.Distance),
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 2),
                    width: 330,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "Next",
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
      ),
    );
  }
}
