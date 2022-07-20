import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:web_admin_panel/Screen/HomeScreen/home_screem.dart';
import 'package:web_admin_panel/Screen/LoginScreen/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Get.to(LoginScreen());
        } else {
          Get.to(HomeScreen());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitSquareCircle(
            color: Color(0xFFFF5733),
            size: 50.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Admin Panel",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
