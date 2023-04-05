import 'package:csun_user/global/global.dart';
import 'package:csun_user/widgets/info_design_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget{
  @override 
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userModelCurrentInfo!.name!,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                height: 2,
                thickness: 2,
              ),
            ),
            const SizedBox(height: 38),

            InfoDesignUIWiget(
              textInfo: userModelCurrentInfo!.phone!,
              iconData: Icons.phone,
            ),
            InfoDesignUIWiget(
              textInfo: userModelCurrentInfo!.email!,
              iconData: Icons.email_rounded,
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
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
      ),
      
    );
  }
}