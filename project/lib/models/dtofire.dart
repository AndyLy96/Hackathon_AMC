import 'package:cloud_firestore/cloud_firestore.dart';

class DtoFire {
  DtoFire();

  String? id;
  String? code;
  String? brands;
  String? categories;
  int? ecoscoreScore;
  String? imageUrl;
  String? ingredientsText;
  int? nutriscoreScore;
  int? nutritionScoreBeverage;
  String? productName;
  String? productNameFr;

  Map<String, dynamic> toFirestore() {
    return {
      "code": code,
      "brands": brands,
      "categories": categories,
      "ecoscoreScore": ecoscoreScore,
      "imageUrl": imageUrl,
      "ingredientsText": ingredientsText,
      "nutriscoreScore": nutriscoreScore,
      "nutritionScoreBeverage": nutritionScoreBeverage,
      "productName": productName,
      "productNameFr": productNameFr,
    };
  }

  factory DtoFire.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    DtoFire resultat = DtoFire();
    resultat.id = snapshot.id;
    resultat.code = data?["brands"];
    resultat.brands = data?["brands"];
    resultat.categories = data?["categories"];
    resultat.ecoscoreScore = data?["ecoscoreScore"];
    resultat.imageUrl = data?["deadline"];
    resultat.ingredientsText = data?["ingredientsText"];
    resultat.nutriscoreScore = data?["nutriscoreScore"];
    resultat.nutritionScoreBeverage = data?["nutritionScoreBeverage"];
    resultat.productName = data?["productName"];
    resultat.productNameFr = data?["productNameFr"];
    return resultat;
  }
}
