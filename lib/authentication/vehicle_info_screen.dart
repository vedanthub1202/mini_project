import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ontheway/global/driver_global.dart';
import 'package:ontheway/splashScreen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController vehiclemodel = TextEditingController();
  TextEditingController vehiclenumber = TextEditingController();
  TextEditingController vehiclecolor = TextEditingController();

  List<String> vehicleTypesList = ["Auto", "Bike", "Car"];
  String? selectedVehicleType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color" : vehiclecolor.text.trim(),
      "car_number" : vehiclenumber.text.trim(),
      "car_model" : vehiclemodel.text.trim(),
      "car_type" : selectedVehicleType,
    };

    DatabaseReference DriversRef = FirebaseDatabase.instance.ref().child("drivers");
    DriversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
    
    Fluttertoast.showToast(msg: "Car Details have been saved");
    Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
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
                //image of driver
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assests/Driver.png"),
                ),

                const Text("Car Details",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //car model
                TextField(
                  controller: vehiclemodel,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Model',
                    hintText: 'Model',
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

                //car number
                TextField(
                  controller: vehiclenumber,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Car Number',
                    hintText: 'Car Number',
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

                // car color
                TextField(
                  controller: vehiclecolor,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Color',
                    hintText: 'Color',
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

                DropdownButton(
                  iconSize: 40,
                  dropdownColor: Colors.black,
                  hint: const Text('please choose vehicle type',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                  ),
                    value: selectedVehicleType,
                    onChanged: (newValue) {
                    setState(() {
                      selectedVehicleType = newValue.toString();
                    });
                    },
                  items: vehicleTypesList.map((car) {
                    return DropdownMenuItem(
                      child: Text(
                        car,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      value: car,
                    );
                  }).toList(),
                    ),

                const SizedBox(height: 20,),

                ElevatedButton(onPressed: () {
                  if(vehiclecolor.text.isNotEmpty && 
                      vehiclenumber.text.isNotEmpty &&
                      vehiclemodel.text.isNotEmpty && selectedVehicleType != null)
                    {
                      saveCarInfo();
                    }
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  child: const Text('Save Now',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
