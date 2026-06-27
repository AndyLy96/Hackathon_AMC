import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:project/models/product.dart';

const String url = 'url';
const String urlServeur = 'https://world.openfoodfacts.net/api/v2/product';

class SingletonDio {
  //static var cookiemanager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    //dio.interceptors.add(cookiemanager);
    dio.options.headers['Content-Type'] = 'application/json';
    return dio;
  }
}

Future<Product> requeteMerdique(String Upc) async {
  try {
    Response response =
        await SingletonDio.getDio().get('$urlServeur/' + Upc + '.json');
    if (response.statusCode == 200) {
      Product prod = Product.fromJson(response.data);
      print(prod.code! + "allooooooo");
      print(prod.brands);
      print(prod.productNameFr);
      print(prod.productName);
      print(prod.nutritionScoreBeverage);
      print(prod.nutriscoreScore);
      print(prod.ingredientsText);
      print(prod.ecoscoreScore);
      return prod;
    } else {
      // Handle other status codes if needed
      throw Exception('Failed to load product');
    }
    // var listeJSON = response.data as List;
    // var listeHomeItemPhotoResponse = listeJSON.map((elementJSON) {
    //   return HomeItemPhotoResponse.fromJson(elementJSON);
    // }).toList();
    // return listeHomeItemPhotoResponse;
  } catch (e) {
    throw (e);
  }
}
