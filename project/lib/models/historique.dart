import 'package:flutter/material.dart';
import 'package:project/Login.dart';
import 'package:project/details.dart';
import 'package:project/main.dart';
import 'package:project/models/dtofire.dart';
import 'package:project/models/product.dart';
import 'package:project/requetes_firebase/requetes_fire.dart';

import '../Views/CreationPlan/CreationEtape1.dart';
import 'http.dart';

class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  String imageURL = "";
  Stream<List<DtoFire>> monStream = dtoFireCommeUnStream();
  int _selectedIndex = 0;

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
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: Text(
                "Historique",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: StreamBuilder<List<DtoFire>>(
                    stream: monStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<DtoFire>> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString() + 'alloooo');
                        return const Text('Reloading');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      List<DtoFire> data = snapshot.data!;

                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          DtoFire item = data[index];
                          return Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: ListTile(
                                    title: Text(item.productName!),
                                    subtitle: Text(item.brands ?? 'null'),
                                    onTap: () async {
                                      Product p = new Product(code: item.code);
                                      p.nutritionScoreBeverage =
                                          item.nutritionScoreBeverage;
                                      p.categories = item.categories;
                                      p.ecoscoreScore = item.ecoscoreScore;
                                      p.imageUrl = item.imageUrl;
                                      p.ingredientsText = item.ingredientsText;
                                      p.nutriscoreScore = item.nutriscoreScore;
                                      p.productName = item.productName;
                                      p.productNameFr = item.productNameFr;
                                      p.brands = item.brands;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(prod: p)),
                                      );
                                    },
                                  )));
                        },
                      );
                    })),
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
                      label: 'Historique',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add,
                        size: 40,
                      ),
                      label: 'Home',
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
    );
  }
}
