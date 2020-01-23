import 'package:accionlabs/screens/login_screen.dart';
import 'package:accionlabs/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import '../services/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/list_employees.dart';
import 'error_screen.dart';
import '../utilities/sign_up.dart';
import 'package:sweetalert/sweetalert.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  HomeScreen(this.email);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isWaiting;
  bool userBool = true;
  String userLogged;
  Map<String, dynamic> userDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: userBool ? Text("fetching") : Text(userDetails["FirstName"]),
            ),
            FlatButton(
              onPressed: () async {
                print("Logged out");
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("user");
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    }
                ));
                signOutGoogle();
              },
              child: Text("LogOut"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white10, Colors.yellow[50]],
            )),
            child: isWaiting
                ? spinner()
                : employee.length > 0
                    ? ListEmployees(employee)
                    : ServerError()),
      ),
    );
  }

  List employee = [];
  List filterEmployee = [];

  getData() async {
    isWaiting = true;
    try {
      var data = await getEmployeeData();
      setState(() {
        employee = data["data"];
        filterEmployee = employee;
        isWaiting = false;
      });
    } catch (err) {
      return setState(() {
        isWaiting = false;
      });
    }
  }

  getEmployee() async {
    try{
      var data = await getEmployeeByEmail(widget.email);
      setState(() {
        userDetails = data["result"][0];
        userBool = false;
      });
    } catch (err){
      return err;
    }
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() async {
      userLogged = await prefs.getString(key) ?? "";
    });
  }

  @override
  void initState() {
    getData();
    getEmployee();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Log in succesfull",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            duration: Duration(milliseconds: 2000))));
    super.initState();
  }
}
