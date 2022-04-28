 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ontheway/authentication/driver_signup.dart';
import 'package:ontheway/authentication/vehicle_info_screen.dart';
import 'package:ontheway/splashScreen/splash_screen.dart';

import '../Widgets/driver_progress_dialog.dart';
import '../global/driver_global.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({Key? key}) : super(key: key);

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {

  TextEditingController driveremail = TextEditingController();
  TextEditingController driverpassword = TextEditingController();

  validateForm() {
    if(!driveremail.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email Address is not valid");
    }
    else if(driverpassword.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters");
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return DriverProgressDialog(message: "Processing, Please wait..",);
        }
    );

    final User? firebaseUser = (
        await firebaseAuth.signInWithEmailAndPassword(
          email: driveremail.text.trim(),
          password: driverpassword.text.trim(),
        ).catchError((msg) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error.. During Login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children:  [
                //image of driver
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assests/Driver.png"),
                ),

                const Text("Login as a Driver",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //email
                TextField(
                  controller: driveremail,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'email',
                    hintText: 'email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),

                //password
                TextField(
                  controller: driverpassword,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'password',
                    hintText: 'password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                ElevatedButton(onPressed: () {
                  validateForm();
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  child: const Text('Login',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),),
                ),
                
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => DriverSignUp()));
                },
                    child: const Text("Do not have account? Register Here",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
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
