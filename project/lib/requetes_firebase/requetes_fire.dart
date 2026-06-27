import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/models/dtofire.dart';
import 'package:project/models/product.dart';

final productCollectionRef = getProductCollection();

CollectionReference<DtoFire> getProductCollection() {
  User? user = FirebaseAuth.instance.currentUser;

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('DtoFire')
      .withConverter<DtoFire>(
          fromFirestore: DtoFire.fromFirestore,
          toFirestore: (DtoFire dtoFire, options) => dtoFire.toFirestore());
}

signout() async {
  await GoogleSignIn().signOut();
  await FirebaseAuth.instance.signOut();
}

Future<List<DtoFire>> getListDtoFire() async {
  QuerySnapshot<DtoFire> results = await productCollectionRef.get();
  return _convertirRequeteEnListe(results);
}

List<DtoFire> _convertirRequeteEnListe(QuerySnapshot<DtoFire> requete) {
  List<DtoFire> resultat = [];
  for (QueryDocumentSnapshot<DtoFire> element in requete.docs) {
    resultat.add(element.data());
  }
  return resultat;
}

Stream<List<DtoFire>> dtoFireCommeUnStream() {
  Stream<List<DtoFire>> flot = productCollectionRef
      .snapshots()
      .map((QuerySnapshot<DtoFire> query) => _convertirRequeteEnListe(query));
  return flot;
}

getDtoFire(String id) {
  productCollectionRef.doc(id);
}

Future<void> addProduct(Product prod) async {
  DtoFire dto = DtoFire();
  if (prod == null) {
    throw 'ProductIsNull';
  }
  dto.brands = prod.brands;
  dto.productNameFr = prod.productNameFr;
  dto.productName = prod.productName;
  dto.code = prod.code;
  dto.nutriscoreScore = prod.nutriscoreScore;
  dto.ingredientsText = prod.ingredientsText;
  dto.imageUrl = prod.imageUrl;
  dto.ecoscoreScore = prod.ecoscoreScore;
  dto.categories = prod.categories;
  dto.nutritionScoreBeverage = prod.nutritionScoreBeverage;

  List<DtoFire> listDtoFire = await getListDtoFire();

  await productCollectionRef.add(dto);
}
