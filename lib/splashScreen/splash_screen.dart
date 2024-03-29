import 'dart:async';
import 'package:csun_user/authentication/login_screen..dart';
import 'package:csun_user/mainScreens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:csun_user/assistants/assistant_methods.dart';
import 'package:csun_user/global/global.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    fAuth.currentUser != null
        ? AssistantMethods.readCurrentOnlineUserInfo()
        : null;

    Timer(const Duration(seconds: 2), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // color: Colors.black,
        color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/Logo.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Shuttle",
                style: TextStyle(
                    fontSize: 24,
                    // color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
