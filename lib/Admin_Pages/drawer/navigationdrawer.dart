import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/Initial_Page/Initial_Page.dart';
import 'package:myproject/Admin_Pages/drawer/widget/DrawerItem.dart';
import 'package:myproject/All_User_Pages/google_sign_in/google_sign_in.dart';
import 'package:myproject/Admin_Pages/drawer/widget/DrawerHeader.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:provider/provider.dart';

class navigationDrawerAdmin extends StatelessWidget {
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.deepPurple),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.deepPurple),
      ),
      onPressed: () async {
        print(login);
        if (login == 1) {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, MyRoutes.initialRoute);
        } else if (login == 2) {
          Navigator.pushNamed(context, MyRoutes.initialRoute);
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.Logout();
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.home,
            text: 'Dashboard',
            onTap: () => Navigator.pushReplacementNamed(
                context, MyRoutes.AdminDashboard),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Users',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.Users),
          ),
          createDrawerBodyItem(
            icon: Icons.account_box,
            text: 'Drivers Application',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.Drivers),
          ),
          createDrawerBodyItem(
            icon: Icons.check_box,
            text: 'Approved Drivers',
            onTap: () => Navigator.pushReplacementNamed(
                context, MyRoutes.AcceptedDrivers),
          ),
          createDrawerBodyItem(
            icon: Icons.close_sharp,
            text: 'Rejected Drivers',
            onTap: () => Navigator.pushReplacementNamed(
                context, MyRoutes.RejectedDrivers),
          ),
          createDrawerBodyItem(
            icon: Icons.car_rental_sharp,
            text: 'Trips on the way',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.TripsOnTheWay),
          ),
          createDrawerBodyItem(
            icon: Icons.car_rental_sharp,
            text: 'Completed Trips',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.TripsOnTheWay),
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.star,
            text: 'Feedbacks',
            onTap: () => Navigator.pushReplacementNamed(
                context, MyRoutes.FeedbackScreen),
          ),
          createDrawerBodyItem(
            icon: Icons.exit_to_app,
            text: 'Logout',
            onTap: () => showAlertDialog(context),
          ),
          SizedBox(
            height: 180,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListTile(
              title: Text('App version 1.0.0'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
