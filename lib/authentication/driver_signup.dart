import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ontheway/Widgets/driver_progress_dialog.dart';
import 'package:ontheway/authentication/driver_login.dart';
import 'package:ontheway/authentication/vehicle_info_screen.dart';

import '../global/driver_global.dart';

class DriverSignUp extends StatefulWidget {
  const DriverSignUp({Key? key}) : super(key: key);

  @override
  State<DriverSignUp> createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {

  TextEditingController drivername = TextEditingController();
  TextEditingController driveremail = TextEditingController();
  TextEditingController driverphone = TextEditingController();
  TextEditingController driverpassword = TextEditingController();

  validateForm() {
    if(drivername.text.length<3)
      {
        Fluttertoast.showToast(msg: "name must be atleast 3 characters");
      }
    else if(!driveremail.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email Address is not valid");
      }
    else if(driverphone.text.isEmpty)
      {
        Fluttertoast.showToast(msg: "Phone number is required");
      }
    else if(driverpassword.text.length < 6)
      {
        Fluttertoast.showToast(msg: "Password must be atleast 6 characters");
      }
    else
      {
        saveDriverinfo();
      }
  }

  saveDriverinfo() async
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
        await firebaseAuth.createUserWithEmailAndPassword(
            email: driveremail.text.trim(),
            password: driverpassword.text.trim(),
        ).catchError((msg) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
      {
        Map driverMap = {
          "id" : firebaseUser.uid,
          "name" : drivername.text.trim(),
          "Email" : driveremail.text.trim(),
          "Phone no." : driverphone.text.trim(),
        };

        DatabaseReference DriversRef = FirebaseDatabase.instance.ref().child("drivers");
        DriversRef.child(firebaseUser.uid).set(driverMap);

        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Account has been created");
        Navigator.push(context, MaterialPageRoute(builder: (c) => CarInfoScreen()));
      }
    else
      {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Account has not been created");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                // image of driver
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assests/Driver.png"),
                ),


                const Text("Register as a Driver",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                ),

                //name
                TextField(
                  controller: drivername,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Name',
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

                //phone
                TextField(
                  controller: driverphone,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'phone',
                    hintText: 'phone',
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
                    child: const Text('Create Account',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),),
                ),

                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => DriverLogin()));
                },
                  child: const Text("Already have Account? Login Here",
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
