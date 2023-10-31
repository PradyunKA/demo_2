// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:demo_2/components/my_button.dart';
import 'package:demo_2/components/square_tile.dart';
import 'package:demo_2/components/text_fields.dart';
import 'package:demo_2/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
   const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign in user method
  void signUserUp() async {
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
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
      } else {
        //show error message
        showErrorMessage("Passwords Don't Match");

      }
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
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple.shade300], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  
                  Image.asset(
                    "lib/images/logo.png",
                    height: 200,
                    color: Colors.white,
                    ),
                  
                  const SizedBox(
                    height: 10,
                  ),
                    
                  //welcome back message
                  Text(
                    "AllergyAway",
                    style: GoogleFonts.merienda(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  //text fields to input 
                  MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 10,
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

                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                  
                  //forgot passowrd
                  const SizedBox(
                    height: 10,
                  ),
            
                  const SizedBox(
                    height: 25,
                  ),
                  
                  //sign in button
                  MyButton(
                    text: "Sign Up",
                    onTap: signUserUp,
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
                  const SizedBox(height: 30),
            
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google sign in
            
                      
                      SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'
                        ),
            
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
            
                  const SizedBox(
                    height: 20
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?", style: GoogleFonts.oswald(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                      const SizedBox(
                        width: 11,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login Here", 
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