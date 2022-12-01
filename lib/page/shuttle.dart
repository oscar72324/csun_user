import 'package:flutter/material.dart';

class Shuttle extends StatelessWidget{
  // const Shuttle({super.key});
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Shuttle Times"),
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
              "Fall and Spring Schedule",
              style: TextStyle(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 40,
              right: 40,
              bottom: 10,
            ),
            child: Text(
              "Monday through Thursday",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
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
            child: Text("7:00am to 10:00pm"),
          ),
        ),
        Container(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 40,
              right: 40,
              bottom: 10,
            ),
            child: Text(
              "Friday",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
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
              bottom: 10,
            ),
            child: Text("7:00am to 4:30pm"),
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
              bottom: 5,
            ),
            child: Text(
              "Location of Stops",
              style: TextStyle(fontWeight: FontWeight.w800),
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
            child: Text("1) On the South side of Redwood Hall"),
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
            child: Text("2) At the F8 parking lot on Lindley Avenue (at the shelter)"),
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
            child: Text("3) Inside the F10 parking lot on Lindley and Lassen"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: SizedBox(
              height: 50,
              width: 125,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  side: const BorderSide(width: 1),
                ),
                onPressed: (){
                  // draw polyline
                  Navigator.pop(context);
                },
                child: const Text("See Route"),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}