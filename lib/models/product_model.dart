// import 'package:store_app/models/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String image;
  // final RatingModel rating;
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    // required this.rating,
    required this.category
  });

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
      description: jsonData['description'],
      image: jsonData['image'],
      // rating: RatingModel.fromJson(jsonData['rating']),
      category: jsonData['category'],
    );
  }
}