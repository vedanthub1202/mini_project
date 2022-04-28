import 'package:flutter/material.dart';
import 'package:ontheway/global/driver_global.dart';
import 'package:ontheway/splashScreen/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Sign Out"),
        onPressed: () {
          firebaseAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
        },
      ),
    );
  }
}
