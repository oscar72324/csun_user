import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Security extends StatelessWidget{
  final _emergencyNumber = "911";
  final _nonEmergencyNumber = "8186772111";
  // const Security({super.key});
  @override 
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Security'),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 40,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Text(
              "Emergency calls will direct to 911",
              style: TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(width: 1),
              ),
              onPressed: () async{
                final emergencyCall = 'tel:$_emergencyNumber';
                if(await canLaunchUrlString(emergencyCall)){
                  await launchUrlString(emergencyCall);
                }
              },
              child: const Text("Emergency Call 911"),
            ),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 40,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Text("When texting CSUN PD, please include the follow 2 pieces of information: ",
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Text("1) Your emergency"),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Text("2) Your location"),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25, bottom: 10),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(width: 1),
              ),
              onPressed: () async{
                final emergencyText = 'sms:$_emergencyNumber';
                if(await canLaunchUrlString(emergencyText)){
                  await launchUrlString(emergencyText);
                }
              },
              child: const Text("Text 911"),
            ),
          ),
        ),

        const Divider(
          height: 50,
          thickness: 2,
          indent: 50,
          endIndent: 50,
          color: Color.fromARGB(255, 104, 104, 104),
        ),

        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Text(
              "The Non-Emergency Line is available 24/7",
              style: TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25),
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(width: 1),
              ),
              onPressed: () async{
                final nonEmergencyCall = 'tel:$_nonEmergencyNumber';
                if(await canLaunchUrlString(nonEmergencyCall)){
                  await launchUrlString(nonEmergencyCall);
                }
              },
              child: const Text("Non-Emergency Call"),
            ),
          ),
        ),
      ],
    ),
  );
}