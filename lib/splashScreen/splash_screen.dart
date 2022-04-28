import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ontheway/authentication/driver_login.dart';
import 'package:ontheway/authentication/driver_signup.dart';
import 'package:ontheway/global/driver_global.dart';
import 'package:ontheway/main_screen/driver_main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if(await firebaseAuth.currentUser != null)
        {
          currentFirebaseUser = firebaseAuth.currentUser;
          Navigator.push(context, MaterialPageRoute(builder: (c)=> DriverMainScreen()));
        }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> DriverLogin()));
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assests/ontheway_logo.png"),
              ),

              SizedBox(height: 10,),

              const Text("OnTheWay",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
