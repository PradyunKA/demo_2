// ignore_for_file: prefer_const_constructors

import 'package:demo_2/pages/allergy_input_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
         
          elevation: 15,
          title: Text(
                    "AllergyAway",
                    style: GoogleFonts.merienda(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )
                  ),
          flexibleSpace: (Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purple])),)),
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
            ),

          
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 148, 30, 217)], 
              begin: Alignment.topLeft, end: Alignment.bottomRight
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Welcome, " + user.displayName! + "!",
                      style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 46, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 25
                    ),
                    Text("Click the button to add your allergies!",style: GoogleFonts.bebasNeue(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),

                    const SizedBox(
                      height: 30,
                    ),

                    
                    ElevatedButton(child: Text("Input allergies"), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AllergyInputPage()));}),

                    

                    
                  ]
                ),
              ),
             ),
          ),
        ),
      ),
    ); 
  }
}