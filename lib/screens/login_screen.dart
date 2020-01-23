import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/sign_up.dart';
import '../services/services.dart';
import 'home_screen.dart';
import 'package:sweetalert/sweetalert.dart';
import '../utilities/shared_preference.dart';
import 'package:transparent_image/transparent_image.dart';
import '../utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetImage("assets/building.jpg"),
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  colors: [Colors.red[300], Colors.black54])),
        ),
        Positioned(
          top: 80,
          left: 40,
          child: Container(
            height: 400,
            width: 340,
            child: Column(
//          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FadeInImage(placeholder: MemoryImage(kTransparentImage) ,image: AssetImage("assets/accionlabs-icon.png")),
                ),
                Text("Driving outcomes through actions",
                    style: TextStyle(shadows: [
                      Shadow(
                          color: Colors.black54,
                          offset: Offset(3.5, 3.5),
                          blurRadius: 2.0)
                    ], color: Colors.white, fontSize: 25)),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: RaisedButton(
                    textColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      var user = await signInWithGoogle();
                      Map<String, dynamic> accionUser =
                          await logIn(user["email"]);
                      if (accionUser["error"] != null) {
                        setState(() {
                          loading = false;
                        });
                        signOutGoogle();
                        SweetAlert.show(context,
                            title: "Invalid User",
                            subtitle: "Try with accion email id",
                            style: SweetAlertStyle.error);
                      }
                      if (accionUser["status"] == 200) {
                        saveSharedPref(accionUser["userData"]["EmailID"]);
                        setState(() {
                          loading = false;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen(accionUser["userData"]["EmailID"]);
                            },
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          height: 40,
                          width: 40,
                          image: AssetImage("assets/google_logo.png"),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: loading
                              ? spinner()
                              : Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      fontSize: 23, letterSpacing: 0.2),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  saveSharedPref(String user) async {
    try {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save("user", user);
      print(sharedPref.read("user"));
    } catch (err) {
      print(err);
    }
  }
}
