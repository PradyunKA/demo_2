// ignore_for_file: prefer_const_constructors

import 'package:demo_2/pages/scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AllergyInputPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final _allergy1 = TextEditingController();
  final _allergy2 = TextEditingController();
  final _allergy3 = TextEditingController();

  
  

   AllergyInputPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: Text(
          "AllergyAway",
          style: GoogleFonts.merienda(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      flexibleSpace: (
        Container(
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        )
      ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple,Colors.purple.shade200,],
            begin: Alignment.topLeft, end: Alignment.bottomRight

          )
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "Please Enter your dietary restrictions",
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _allergy1,
                      decoration: InputDecoration(
                        hintText: "Enter an allergy",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: () {_allergy1.clear();}, icon: const Icon(Icons.clear)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                  
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _allergy2,
                      decoration: InputDecoration(
                        hintText: "Enter an allergy",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: () {_allergy2.clear();}, icon: const Icon(Icons.clear)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                  
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _allergy3,
                      decoration: InputDecoration(
                        hintText: "Enter an allergy",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(onPressed: () {_allergy3.clear();}, icon: const Icon(Icons.clear)),
                        filled: true,
                        fillColor: Colors.white,
                      ),                 
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(onPressed: () async {
                    await users.add({'allergy1': _allergy1.text, 'allergy2': _allergy2.text, 'allergy3': _allergy3.text}).then((value) => print("User Details Added"));
                  }, child: Text("Submit Data")),
                  ElevatedButton(child: Text("Scan a Barcode"), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerPage(allergyone: _allergy1.text, allergytwo: _allergy2.text, allergythree: _allergy3.text,),));},),
                  
                  
                ],
                
              ),
            )
          )
        ),

      ),
      

      );
      

  }
}