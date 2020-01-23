import 'dart:async';
import 'dart:convert';
import 'package:accionlabs/screens/home_screen.dart';
import 'package:accionlabs/services/services.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'utilities/shared_preference.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(FirstScreen());
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String userLogged;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SplashScreen(
            image: Image(image: AssetImage("assets/accionlabs-icon.png")),
            seconds: 1,
            photoSize: 250,
            navigateAfterSeconds: HomePage(userLogged),
          ),
        ),
      ),
    );
  }
  getSharedPreference() async{
    String value = await SharedPref().read("user");
    setState(() {
      userLogged = value;
    });
  }
  @override
  void initState(){
    getSharedPreference();
    super.initState();
  }
}


class HomePage extends StatelessWidget {
  final String email;
  HomePage(this.email);
  @override
  Widget build(BuildContext context) {
    return email == null ? LoginScreen() : HomeScreen(email);
  }
}





