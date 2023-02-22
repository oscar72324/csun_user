import 'package:flutter/material.dart';

class InfoDesignUIWiget extends StatefulWidget {
  String? textInfo;
  IconData? iconData;

  InfoDesignUIWiget({this.iconData, this.textInfo});

  @override
  State<InfoDesignUIWiget> createState() => _InfoDesignUIWigetState();
}

class _InfoDesignUIWigetState extends State<InfoDesignUIWiget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: ListTile(
        leading: Icon(
          widget.iconData,
          color: Colors.black,
        ),
        title: Text(
          widget.textInfo!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}