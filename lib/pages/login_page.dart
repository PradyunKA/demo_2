// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:demo_2/components/my_button.dart';
import 'package:demo_2/components/square_tile.dart';
import 'package:demo_2/components/text_fields.dart';
import 'package:demo_2/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
   const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user method
  void signUserIn() async {
    //show loading circle 
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
          );
      },
      );


    // try sign in 
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
    );
    //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle if error
      Navigator.pop(context);
      //show error message 
      showErrorMessage(e.code);
    }
  }


//error message
  void showErrorMessage(String message) {
    showDialog(
      context: context, 
      builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            message,
            style: GoogleFonts.oswald(
              color: Colors.white
            ),
          ),
        ),
      );
    },
    ); 
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 148, 30, 217)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Image.asset(
                    "lib/images/logo.png",
                    height: 225,
                    color: Colors.white,
                    ),
                  
                  const SizedBox(
                    height: 25,
                  ),
                    
                  //welcome back message
                  Text(
                    "AllergyAway",
                    style: GoogleFonts.merienda(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  
                  //text fields to input 
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
            
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  
                  //forgot passowrd
                  const SizedBox(
                    height: 10,
                  ),
            
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.oswald(
                            fontSize: 15, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                          ),
                      ],
                    ),
                  ),
            
                  const SizedBox(
                    height: 10,
                  ),
                  
                  //sign in button
                  MyButton(
                    text: "Sign In",
                    onTap: signUserIn,
                  ),
            
                  const SizedBox(height: 25.0,),
                  
                  //or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0),
                          child: Text(
                            "Or Continue With",
                            style: GoogleFonts.oswald(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),
                            ),
                        ),
                  
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ), 
            
                  //google or apple sign in 
                  const SizedBox(height: 15),
            
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google sign in
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'
                        ),
            
                      const SizedBox(
                        width: 20,
                      ),
            
            
                      //apple sign in
                      
                    ],
                  ),
            
                  const SizedBox(
                    height: 20
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?", style: GoogleFonts.oswald(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                      const SizedBox(
                        width: 11,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Register Now", 
                          style: GoogleFonts.oswald(
                            fontSize: 15, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  )                                
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}