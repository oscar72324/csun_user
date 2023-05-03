import 'package:flutter/material.dart';

import '../global/global.dart';

class Metro extends StatelessWidget{
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Metrolink Shuttle Times", style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.red,
    ),
    body: Scaffold(
      backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              right: 30,
              left: 30,
              bottom: 0,
            ),
            child: Text(
              "The free shuttle brings passengers to/from CSUN and Northridge Metrolink Station",
              style: TextStyle(fontWeight: FontWeight.w800, color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
              bottom: 10,
            ),
            child: Text(
              "CSUN Location: CSUN Transit Station (located on Vincennes, north of Valera Hall)",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 30,
            thickness: 2,
            indent: 50,
            endIndent: 50,
            color: Color.fromARGB(255, 104, 104, 104),
          ),
          // Container(
          //   child: const Padding(
          //     padding: EdgeInsets.only(
          //       top: 10,
          //       right: 30,
          //       left: 30,
          //       bottom: 0,
          //     ),
          //     child: Text(
          //       "In the morning, the CSUN Metrolink Shuttle picks up passengers from all trains that are scheduled to arrive at the Northridge Metrolink Station between 6:52 and 9:16 am",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              right: 30,
              left: 30,
              bottom: 0,
            ),
            child: Text(
              "Morning (AM) Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
            ),
            textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Center(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Train",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "101",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "104",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "103",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A761",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "108",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A770",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "110",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
    
                  const SizedBox(
                    width: 20,
                  ),
    
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Arrival Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "6:52 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:06 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:30 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:55 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "8:27 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "8:58 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "9:16 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
    
                  const SizedBox(
                        width: 20,
                      ),
    
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Departure Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "6:52 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:06 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:30 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "7:55 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "8:27 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "8:58 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "9:16 am",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   child: const Padding(
          //     padding: EdgeInsets.only(
          //       top: 10,
          //       right: 30,
          //       left: 30,
          //       bottom: 0,
          //     ),
          //     child: Text(
          //       "In the afternoon, the CSUN Metrolink Shuttle takes passengers back to meet their afternoon trains. To return to the Northridge Metrolink Station by Shuttle, passengers must board the shuttle at the CSUN Transit Station",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: 30,
                left: 30,
                bottom: 0,
              ),
              child: Text(
                "Afternoon and Evening (PM) Schedule",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
              ),
              textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              right: 40,
              left: 40,
              bottom: 0,
            ),
            child: Center(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Train",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "116",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A777",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "115",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "117",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "118",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "119",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
    
                  const SizedBox(
                    width: 20,
                  ),
    
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Shuttle Departs",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "2:28 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "3:30 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "3:30 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "4:45 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5:15 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5:30 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
    
                  const SizedBox(
                        width: 20,
                      ),
    
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "Train Departs",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black
                          ),
                        ),
                      ),
    
                      const SizedBox(
                        height: 10,
                      ),
    
                      Text(
                        "2:51 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "3:55 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "4:15 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5:06 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5:36 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "5:48 pm",
                        style: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}