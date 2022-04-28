import 'package:flutter/material.dart';

class DriverProgressDialog extends StatelessWidget {
  String? message;
  DriverProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 6,),

              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),

              const SizedBox(width: 6,),

              Text(message!,style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
