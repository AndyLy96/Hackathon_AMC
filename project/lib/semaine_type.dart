import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemaineType extends StatefulWidget {
  @override
  _SemaineTypeState createState() => _SemaineTypeState();
}

class _SemaineTypeState extends State<SemaineType> {
  List<String> weekDays = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
  ];

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
              padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
              child: Text("Statistiques"),
            ),
            Container(
              child: Text("photo disant si bonne semaine"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: weekDays.length,
                  itemBuilder: (BuildContext context, int index) {
                    String jourCourant = weekDays[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                        boxShadow: [
                          BoxShadow(color: Colors.green, spreadRadius: 3),
                        ],
                      ),
                      child: ListTile(
                        title: Text(jourCourant),
                        subtitle: Text("29 janvier 2024"),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
