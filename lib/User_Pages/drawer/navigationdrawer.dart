import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/Initial_Page/Initial_Page.dart';
import 'package:myproject/User_Pages/drawer/widget/DrawerItem.dart';
import 'package:myproject/All_User_Pages/google_sign_in/google_sign_in.dart';
import 'package:myproject/User_Pages/drawer/widget/DrawerHeader.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navigationDrawer extends StatefulWidget {
  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
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
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.Logout();
          Navigator.pushNamed(context, MyRoutes.initialRoute);
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

  String? MyUserID;
  void getUserCredentioals() async {
    final prefs = await SharedPreferences.getInstance();
    MyUserID = prefs.getString('UserAuthID');
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
            text: 'Home',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.homeRoute),
          ),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTap: () => Navigator.pushReplacementNamed(
                context, MyRoutes.myProfileRoute),
          ),
          createDrawerBodyItem(
            icon: Icons.shopping_basket,
            text: 'Orders',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.myOrdersRoot),
          ),
          Divider(),
          createDrawerBodyItem(
            icon: Icons.notifications_active,
            text: 'Notifications',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.homeRoute),
          ),
          createDrawerBodyItem(
            icon: Icons.contact_phone,
            text: 'Contact Info',
            onTap: () =>
                Navigator.pushReplacementNamed(context, MyRoutes.homeRoute),
          ),
          createDrawerBodyItem(
            icon: Icons.exit_to_app,
            text: 'Logout',
            onTap: () => showAlertDialog(context),
          ),
          SizedBox(
            height: 250,
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
