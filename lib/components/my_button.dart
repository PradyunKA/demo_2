// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(8), ),
        child: Center(
          child: Text(
          text,
          style: GoogleFonts.oswald(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
    
    
          ),
        ),
        ),
      ),
    );
  }
}