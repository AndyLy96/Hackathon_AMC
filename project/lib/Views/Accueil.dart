import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, required product});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  static const IconData qr_code_scanner_rounded =
      IconData(0xf00cc, fontFamily: 'MaterialIcons');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(color: Color(0x71B9B29C)),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('Better life', style: GoogleFonts.exo2(
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      )),
                      SizedBox(height: 15,),
                      Image(image: AssetImage('../lib/images/save-the-earth-man-planting-a-tree-in-flat-style-cartoon-illustration-earth-and-environment-day-free-png.png'), height: 100, width: 200,),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(color: Color(0x714B719F)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 90, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 500,
                                child: Text(
                                  'Découvrez une gamme \nde fonctionnalités personnalisées',
                                  style: GoogleFonts.exo2(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardInfo(
                              'Produit recomandés',
                              '../lib/images/pngtree-balanced-diet-clipart-healthy-food-and-nutritional-concept-cartoon-vector-png-image_6860921-removebg-preview.png',
                              'Découvrez nos \nrecomendations'
                            ),
                            CardInfo('Conseil alimentaire', '../lib/images/pngtree-balanced-diet-clipart-healthy-food-and-nutritional-concept-cartoon-vector-png-image_6860921-removebg-preview.png', 'Découvrez nos \nconseils alimentaire'),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardInfoBas('Semaine type', '../lib/images/pngtree-balanced-diet-clipart-healthy-food-and-nutritional-concept-cartoon-vector-png-image_6860921-removebg-preview.png', 'Crée votre \nplanning du future'),
                            CardInfoBas('Conséquence', '../lib/images/pngtree-balanced-diet-clipart-healthy-food-and-nutritional-concept-cartoon-vector-png-image_6860921-removebg-preview.png', 'Coséquences que \notre alimentation procure'),


                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 25,
                  height: 90,
                  width: 350,
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circularProgress(),
                        circularProgress(),
                        circularProgress(),
                        circularProgress(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              qr_code_scanner_rounded,
              size: 40,
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  Container CardInfoBas(String title, String imagePath, String description) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      padding: EdgeInsets.all(10),
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imagePath),
            height: 90,
            width: 100,
          ),
          Text(
            title,
            style: GoogleFonts.exo2(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          Text(
            description,
            style: GoogleFonts.exo2(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Container CardInfo(String title, String imagePath, String description) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.all(10),
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imagePath),
            height: 90,
            width: 100,
          ),
          Text(
            title,
            style: GoogleFonts.exo2(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          Text(
            description,
            style: GoogleFonts.exo2(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Column circularProgress() {
    return Column(
      children: [
        SizedBox(
          height: 13.5,
        ),
        Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 50,
                height: 50,
                child: new CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.green,
                  value: 0.7,
                ),
              ),
            ),
            Text("22/"),
          ],
        ),
        Text('Glucide')
      ],
    );
  }
}
