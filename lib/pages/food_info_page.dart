import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class FoodInfoPage extends StatefulWidget {
  var scanResult;
  var allergy1;
  var allergy2;
  var allergy3;
  FoodInfoPage({Key? mykey, this.scanResult, this.allergy1, this.allergy2, this.allergy3 }) : super(key: mykey);
    

  @override
  State<FoodInfoPage> createState() => _FoodInfoPageState();
}


class _FoodInfoPageState extends State<FoodInfoPage> {
  
  
  String name = '';
  String image = '';
  String allergy1 = '';
  String allergy2 = '';
  String allergy3 = '';
  List containedList = [];
  String items = '';

  Future getFoods(scanResult) async {
    var response = await http.get(Uri.https('world.openfoodfacts.net', '/api/v2/product/$scanResult'));
    var jsonData = jsonDecode(response.body);
    String product_name_en = jsonData['product']['product_name_en'];
    name = product_name_en;
    String image_url = jsonData['product']['image_url'];
    image = image_url;
    String ingredients_text_en = jsonData['product']['ingredients_text_en'];
    String ingredients = ingredients_text_en;
    if (ingredients.contains(widget.allergy1)) {
      allergy1 = widget.allergy1;
      containedList.add(allergy1);
    }
    if (ingredients.contains(widget.allergy2)) {
      allergy2 = widget.allergy2;
      containedList.add(allergy2);
    }
    if (ingredients.contains(widget.allergy3)) {
      allergy1 = widget.allergy3;
      containedList.add(allergy3);
      print(containedList);
    }
    items = containedList.join(', ');

  }



  

  
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        title: Text("AllergyAway",
            style: GoogleFonts.merienda(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        flexibleSpace: (Container(
          decoration:  const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.deepPurple, Colors.purple])),
        )),
      ),
      body: Container(
        decoration:  BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.purple.shade200,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child:  SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: getFoods(widget.scanResult), 
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(image, scale: 1.5,),

                                const SizedBox(height: 25),

                                Text(name, style: GoogleFonts.bebasNeue(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),),
                                const SizedBox(height: 180),
                                Text('$items' + " are in this item!", style: GoogleFonts.bebasNeue(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                                
                                
                                

                              ],
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }      
                      },
                      
                    ),
                    
                  ],
                ),
              ),
            )
          ),
        ),
      );
  }
}
