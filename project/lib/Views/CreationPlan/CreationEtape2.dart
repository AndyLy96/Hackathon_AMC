import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../Login.dart';
import '../../details.dart';
import '../../main.dart';
import '../../models/historique.dart';
import '../../models/http.dart';
import '../../models/product.dart';
import 'CreationEtape1.dart';

class CreationPlan2 extends StatefulWidget {
  const CreationPlan2({super.key});

  @override
  State<CreationPlan2> createState() => _CreationPlan2State();
}


class _CreationPlan2State extends State<CreationPlan2>{

  var _selectedIndex = 1;
  var _scanBarcodeResult;

  List<Product> listProducts = [];

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);

      Product prod = await requeteMerdique(barcodeScanRes);
      listProducts.add(prod);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF54ab79),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child : Column(
                children: [
                  Text('Afin de crée votre plan',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                  ),),
                  Text('Veuillez scanez les produits que vous consommez au quotidien', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ), textAlign: TextAlign.center,),
                ],
              ),
              
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40))
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 25,
                        child: ListView.builder(
                            itemCount: listProducts.length,
                            itemBuilder: (context, index){
                              final item = listProducts[index];
                              if(item != null){
                                return Container(
                                  margin: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      border: Border.all(
                                        width: 2.5,
                                        color: Colors.black,
                                      )
                                  ),
                                  child: ExpansionTile(
                                      title: Text(item.productName!),
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Score Nutrition : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                  Text(item.nutriscoreScore.toString(), style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Ingredients : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                  Text(item.ingredientsText.toString(), style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text('Categorie : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                  Text(item.categories.toString(), style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ]
                                  ),

                                );}
                              }



                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                          border: Border.all(
                            width: 2.5,
                            color: Colors.black,
                          )
                        ),
                        child: ExpansionTile(
                          title: Text('Birth of Universe'),
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Score Nutrition : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                        Text(' Big Bang', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Ingredients : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                        Text(' Big Bang', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Categorie : ', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                        Text(' Big Bang', style: TextStyle(fontWeight: FontWeight.w400), textAlign: TextAlign.right,),
                                      ],
                                    ),
                                  ],
                                ),
                              )

                            ]
                        ),
                      ),
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
                      ),                    ],
                  ),
                )
            )

          ],
        ),
    );
  }

  Container navBar() {
    return Container(
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
    );
  }
}