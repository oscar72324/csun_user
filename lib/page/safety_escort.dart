import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SafetyEscort extends StatelessWidget{
  String? _phoneNumber = "8186775042";

  // const SafetyEscort({super,key})
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      shape: Border(bottom: BorderSide(
        color: Colors.black,
        width: 0.5,
      )),
      iconTheme: IconThemeData(color: Colors.white),
      toolbarHeight: 100,
      // title: Text("Call us for a Safety Escort"),
      centerTitle: true,
      // backgroundColor: Colors.red,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/MatadorRed.psd'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    ),
    body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text(
                  "Free personal safety escorts for students, faculty, staff, and visitors from Monday to Thursday, dusk to 11:00 p.m.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  "NOTE: A police officer is availabe after 11:00 p.m. all other times when Matador Patrol is not on duty.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700
                    ),
                  textAlign: TextAlign.center,
                  ),
              ),
            ),
            Divider(
              height: 50,
              thickness: 2,
              indent: 50,
              endIndent: 50,
              color: Color.fromARGB(255, 104, 104, 104),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 40,
                  right: 40,
                  bottom: 10,
                ),
                child: Text(
                  "Please provide the dispatcher with the following 4 pieces of information: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('1) Your name'),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('2) Your location'),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('3) Your contact number'),
              ),
            ),Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('4) Your destination'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(width: 1),
                  ),
                  onPressed: () async{
                    final _call = 'tel:$_phoneNumber';
                    final _text = 'sms:$_phoneNumber';
                    if(await canLaunchUrlString(_call)){
                      await launch(_call);
                    }
                  },
                  child: Text("Call"),
                ),
              ),
            ),
          ],
        ),
  );
}