import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  String? brands;
  String? categories;
  String? code;
  int? ecoscoreScore;
  String? imageUrl;
  String? ingredientsText;
  int? nutriscoreScore;
  int? nutritionScoreBeverage;
  String? productName;
  String? productNameFr;

  Product(
      {required this.code,
      this.brands,
      this.categories,
      this.ecoscoreScore,
      this.imageUrl,
      this.ingredientsText,
      this.nutriscoreScore,
      this.nutritionScoreBeverage,
      this.productName,
      this.productNameFr});

  // factory product.fromJson(Map<String, dynamic> json) =>
  //     _$productFromJson(json);
  // Map<String, dynamic> toJson() => _$productToJson(this);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        code: json['code'],
        brands: json['product']['brands'],
        categories: json['product']['categories'],
        ecoscoreScore: json['product']['ecoscore_score'],
        imageUrl: json['product']['image_url'],
        ingredientsText: json['product']['ingredients_text'],
        nutriscoreScore: json['product']['nutriscore_score'],
        nutritionScoreBeverage: json['product']['nutrition_score_beverage'],
        productName: json['product']['product_name'],
        productNameFr: json['product']['product_name_fr']);
  }
}
