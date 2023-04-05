import 'package:flutter/material.dart';

class Metro extends StatelessWidget{
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Metrolink Shuttle Times"),
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
              top: 25,
              right: 30,
              left: 30,
              bottom: 0,
            ),
            child: Text(
              "The free shuttle brings passengers to/from CSUN and Northridge Metrolink Station",
              style: TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
              bottom: 10,
            ),
            child: Text(
              "CSUN Location: CSUN Transit Station (located on Vincennes, north of Valera Hall)",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
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
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 30,
              left: 30,
              bottom: 0,
            ),
            child: Text(
              "Morning (AM) Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: const SizedBox(
            height: 15,
          ),
        ),
        Container(
          child: Padding(
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
                        child: const Text(
                          "Train",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "101",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "104",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "103",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "A761",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "108",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "A770",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "110",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Arrival Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "6:52 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:06 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:30 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:55 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "8:27 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "8:58 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "9:16 am",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                        width: 20,
                      ),

                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Departure Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "6:52 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:06 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:30 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "7:55 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "8:27 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "8:58 am",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "9:16 am",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
          child: const Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 30,
              left: 30,
              bottom: 0,
            ),
            child: Text(
              "Afternoon and Evening (PM) Schedule",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: const SizedBox(
            height: 15,
          ),
        ),
        Container(
          child: Padding(
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
                        child: const Text(
                          "Train",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "116",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "A777",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "115",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "117",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "118",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "119",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Shuttle Departs",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "2:28 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "3:30 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "3:30 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "4:45 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "5:15 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "5:30 pm",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                        width: 20,
                      ),

                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Train Departs",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: const Text(
                          "2:51 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "3:55 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "4:15 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "5:06 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "5:36 pm",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: const Text(
                          "5:48 pm",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}