import 'package:csun_user/global/global.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SafetyEscort extends StatelessWidget{
  final _line1 = "8186775042";
  final _line2 = "8186775048";

  // const SafetyEscort({super,key})
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          shape: const Border(
              bottom: BorderSide(
            color: Colors.black,
            width: 0.5,
          )),
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          // title: Text("Call us for a Safety Escort"),
          centerTitle: true,
          // backgroundColor: Colors.red,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/MatadorRed.psd'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: Scaffold(
          backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text(
                  "Free personal safety escorts for students, faculty, staff, and visitors from Monday to Thursday, dusk to 11:00 p.m.",
                  style: TextStyle(fontWeight: FontWeight.w700, color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40, 
                  left: 40,
                  right: 40,
                  bottom: 10
                ),
                child: Text(
                  "NOTE: A police officer is available after 11:00 p.m. all other times when Matador Patrol is not on duty.",
                  style: TextStyle(fontWeight: FontWeight.w700, color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                height: 50,
                thickness: 2,
                indent: 50,
                endIndent: 50,
                color: Color.fromARGB(255, 104, 104, 104),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 40,
                  right: 40,
                  bottom: 10,
                ),
                child: Text(
                  "Please provide the dispatcher with the following 4 pieces of information: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('1) Your name', style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('2) Your location', style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('3) Your contact number', style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  left: 40,
                  bottom: 0,
                ),
                child: Text('4) Your destination', style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(width: 1),
                            ),
                            onPressed: () async {
                              final call1 = 'tel:$_line1';
                              // final _text = 'sms:$_phoneNumber';
                              if (await canLaunchUrlString(call1)) {
                                await launchUrlString(call1);
                              }
                            },
                            child: Text("Call Line 1", style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
                          ),
                        ),
                    ),
                    const SizedBox(
                      height: 25,
                      width: 0,
                    ),
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(width: 1),
                            ),
                            onPressed: () async {
                              final call2 = 'tel:$_line2';
                              // final _text = 'sms:$_phoneNumber';
                              if (await canLaunchUrlString(call2)) {
                                await launchUrlString(call2);
                              }
                            },
                            child: Text("Call Line 2", style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
