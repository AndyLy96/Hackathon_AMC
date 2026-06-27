import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Login.dart';
import 'package:project/details.dart';
import 'package:project/firebase/firebase_api.dart';
import 'package:project/firebase/firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:project/models/historique.dart';
import 'package:project/models/http.dart';
import 'package:project/models/product.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:project/requetes_firebase/requetes_fire.dart';

import 'Views/Accueil.dart';
import 'Views/CreationPlan/CreationEtape1.dart';

import 'Views/CreationPlan/CreationEtape2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Better Life"),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _scanBarcodeResult = "";
  TextEditingController productID = TextEditingController();
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Historique()),
        );
        break;
      case 1:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CreationPlan1()),
        );
        break;
      case 2:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'title')),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Scannez un item en premier'),
          ),
        );
        break;
      case 4:
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        break;
      default:
    }
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);

      Product prod = await requeteMerdique(barcodeScanRes);

      addProduct(prod);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailScreen(prod: prod)));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

  Future<void> typeBarcode(String typedUpc) async {
    // String barcodeScanRes;
    try {
      // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //     '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // debugPrint(barcodeScanRes);

      Product prod = await requeteMerdique(typedUpc);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailScreen(prod: prod)));
    } on Exception {
      throw Exception("mauvais");
    }

    // if (!mounted) return;
    // setState(() {
    //   _scanBarcodeResult = barcodeScanRes;
    // });
  }

  Future<void> submitProduct(String typeUpc) async {
    Product prod = await requeteMerdique(typeUpc);
    addProduct(prod);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(prod: prod)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF54ab79),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          double bottomMargin = isKeyboardVisible ? 190.0 : 50.0;
          isKeyboardVisible ? 190.0 : 50.0; // Ajustez selon vos besoins

          return Builder(
            builder: (context) => Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 95),
                    padding: EdgeInsets.all(30),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 38.0,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'Scannez un produit\n',
                          ),
                          TextSpan(
                            text: 'alimentaire',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 45,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        if (!isKeyboardVisible)
                          ElevatedButton(
                            onPressed: () async {
                              await scanBarcode();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF87eb83),
                              padding: EdgeInsets.all(20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Image.asset(
                              './lib/images/barcode_icon.png',
                              width: 80.0,
                              height: 80.0,
                            ),
                          ),
                        if (!isKeyboardVisible) SizedBox(height: 30.0),
                        if (!isKeyboardVisible)
                          Text(
                            'ou',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        SizedBox(height: 30.0),
                        Text(
                          'Entrez le code du produit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          margin: EdgeInsets.only(left: 35.0, right: 35.0),
                          child: TextField(
                            controller: productID,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(12),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Code UPC du produit',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 20.0,
                              ),
                              fillColor: Color(0xFFFFFF),
                              filled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.only(bottom: bottomMargin),
                          child: ElevatedButton(
                            onPressed: () async {
                              await submitProduct(productID.text.toString());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF87eb83),
                              padding: EdgeInsets.only(
                                  left: 120, right: 120, top: 10, bottom: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              'Rechercher',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: -20,
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: BottomNavigationBar(
                              items: const <BottomNavigationBarItem>[
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.history,
                                    size: 40,
                                  ),
                                  label: 'Accueuil',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.add,
                                    size: 40,
                                  ),
                                  label: 'Créer',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.qr_code,
                                    size: 40,
                                  ),
                                  label: 'Scan',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(
                                    Icons.details,
                                    size: 40,
                                  ),
                                  label: 'Details',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.person, size: 40),
                                  label: 'Profile',
                                ),
                              ],
                              currentIndex: _selectedIndex,
                              onTap: _onItemTapped,
                              elevation: 20.0,
                              selectedItemColor: Color(0xFF1FA055),
                              unselectedItemColor: Colors.grey,
                              selectedIconTheme: IconThemeData(
                                color: Color(0xFF1FA055),
                              ),
                              unselectedIconTheme: IconThemeData(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
