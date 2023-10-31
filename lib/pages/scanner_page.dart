
import 'package:demo_2/pages/food_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';



class ScannerPage extends StatefulWidget {
  ScannerPage({super.key, this.allergyone, this.allergytwo, this.allergythree});
  var allergyone;
  var allergytwo;
  var allergythree;
  


  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? scanResult; 
  String name = '';

  Future scanBarcode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "ffffff", 
        "Cancel", 
        true, 
        ScanMode.BARCODE,
        );

        
    } on PlatformException {
      scanResult = "Failed to get platform version";
    }
    if (!mounted) return;

    setState(() {
      this.scanResult = scanResult;

    });
    
  }

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
                      fontWeight: FontWeight.bold
                    )
                  ),
          flexibleSpace: (Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purple])),)),
          actions: [
          ],
        ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple,Colors.purple.shade200,],
            begin: Alignment.topLeft, end: Alignment.bottomRight

          )
        ),
        child: Center(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: scanBarcode, 
                label: Text("Scan Now"),
              ),
              const SizedBox(height: 15),
      
              Text(
                scanResult == null
                ? 'Scan a Code'
                : 'Scan Result: $scanResult',   
              ),
      
              ElevatedButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodInfoPage(scanResult: scanResult, allergy1: widget.allergyone, allergy2: widget.allergytwo, allergy3: widget.allergythree,)));},child: Text("View Info")),

            ],
          ),
          
        ),
      ),
    );

  }   
  }


