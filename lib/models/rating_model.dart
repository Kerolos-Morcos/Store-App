class RatingModel
{
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> jsonData){
    return RatingModel(
      rate: jsonData['rate'],
      count: jsonData['count'],
    );
  }
}