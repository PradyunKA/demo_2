
import 'package:demo_2/pages/food_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class ScannerPage extends StatefulWidget {
    ScannerPage({super.key});

    

    
    

 

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
      appBar: AppBar(title: Text("SCANNER PAGE")),
      body: Center(
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

            ElevatedButton(onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodInfoPage(scanResult: scanResult,)));},child: Text("View Info")),
          ],
        ),
        
      ),
    );

  }   
  }


