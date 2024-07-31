import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/utils/util.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    

    // Delay for 3 seconds and then check if the user is signed in
    Timer(const Duration(seconds: 3), () {
     // userIsSignedIn();
      User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User is currently signed out
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      // User is signed in
      Util.UID = user.uid;
      print("[Util.UID = ${Util.UID}]");
      Future<void> initUserLocation() async{
        await Util.updateLocation();
        print("[User Location = ${Util.geoPoint}]");
      }
      initUserLocation();
      Navigator.pushReplacementNamed(context, "/home");
    }
    });
  }

  // void userIsSignedIn() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user == null) {
  //     // User is currently signed out
  //     Navigator.pushReplacementNamed(context, "/login");
  //   } else {
  //     // User is signed in
  //     Navigator.pushReplacementNamed(context, "/home");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/spoco_app_logo_black.png", width: 350, height: 350),
      ),
    );
  }
}
