import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Login.dart';
import 'package:project/Views/Accueil.dart';
import 'package:project/models/historique.dart';
import 'package:project/models/product.dart';

import 'Views/CreationPlan/CreationEtape1.dart';
import 'main.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.prod});

  final Product prod;

  @override
  State<StatefulWidget> createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    double squareSize = MediaQuery.of(context).size.width / 2.5 - 20;

    int _selectedIndex = 3;

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
          ;
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
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      prod: widget.prod,
                    )),
          );
          break;
        case 4:
        //NAV PAGE LOGIN
         setState(() {
           _selectedIndex = index;
         });
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => LoginScreen()),
         );
        default:
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product Image
          Container(
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 45,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Color(0xFF54ab79),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    // Half of the width and height for a circle
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ClipOval(
                    child: widget.prod.imageUrl != null
                        ? Image.network(
                            widget.prod.imageUrl!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('/images/Detail-Placeholder.png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Text(
                    widget.prod.productName == null
                        ? "product name is null"
                        : widget.prod.productName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: squareSize,
                height: squareSize,
                padding: EdgeInsets.all(0),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.lerp(
                              Colors.red,
                              Colors.green,
                              widget.prod.ecoscoreScore == null
                                  ? 0
                                  : widget.prod.ecoscoreScore! / 100) ??
                          Colors.red,
                      // Start color (for score 1)
                      Color.lerp(
                              Colors.red,
                              Colors.green,
                              widget.prod.ecoscoreScore == null
                                  ? 0
                                  : widget.prod.ecoscoreScore! / 100) ??
                          Colors.green,
                      // End color (for score 100)
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ecoscore',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            value: widget.prod.ecoscoreScore == null
                                ? 0
                                : widget.prod.ecoscoreScore! / 100,
                            strokeWidth: 6,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.prod.ecoscoreScore == null
                                ? "Introuvable"
                                : widget.prod.ecoscoreScore!.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
// NutriScore Square
              Container(
                width: squareSize,
                height: squareSize,
                padding: EdgeInsets.all(10),
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.lerp(
                              Colors.red,
                              Colors.green,
                              widget.prod.nutriscoreScore == null
                                  ? 0
                                  : widget.prod.nutriscoreScore! / 100) ??
                          Colors.red,
                      // Start color (for score 1)
                      Color.lerp(
                              Colors.red,
                              Colors.green,
                              widget.prod.nutriscoreScore == null
                                  ? 0
                                  : widget.prod.nutriscoreScore! / 100) ??
                          Colors.green,
                      // End color (for score 100)
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NutriScore',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            value: widget.prod.nutriscoreScore == null
                                ? 0
                                : widget.prod.nutriscoreScore! / 100,
                            strokeWidth: 6,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.prod.nutriscoreScore == null
                                ? "Introuvable"
                                : widget.prod.nutriscoreScore.toString()!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFF54ab79),
                ),
                padding: EdgeInsets.all(16),
                // Replace the following Text widget with your scrollable content
                child: Text(
                  'Ingrédients: ' + widget.prod.ingredientsText.toString(),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
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
    );
  }
}
