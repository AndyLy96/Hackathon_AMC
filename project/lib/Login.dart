import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/models/historique.dart';

import 'Views/CreationPlan/CreationEtape1.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //Obtain auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //Create new credentials
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    print("User is signed in");
    //Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  int _selectedIndex = 4;

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
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 100, 20, 60),
                child: Text(
                  textAlign: TextAlign.center,
                  "Connexion avec Google",
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text(
                textAlign: TextAlign.center,
                "Veuillez vous connecter avec un compte google pour accéder à toute les fonctionnalités de l'application.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: ElevatedButton(
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser == null) {
                    var result = await signInWithGoogle();
                    if (result != null) {
                      final db = FirebaseFirestore.instance;
                      await db
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({});
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: "Better Life")));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: "Better Life")));
                  }
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF54ab79)),
                child: Text(
                  "Connexion avec google",
                  style: TextStyle(color: Colors.white),
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
