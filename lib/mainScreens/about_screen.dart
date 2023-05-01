import 'package:csun_user/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatefulWidget{
  @override 
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
      body: ListView(
        children: [
          Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/Logo.png",
              ),
            ),
          ),

          Column(
            children: [
              Text(
                "C-Shuttle",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: appThemeBrightness == Brightness.dark ? Colors.white70 : Colors.black87,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                "This app was made by CSUN students to aid students, visitors, and staff. "
                "We aim to make campus safety and transporation information more accessible to protect our community.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                  color: appThemeBrightness == Brightness.dark ? Colors.white70 : Colors.black87,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}