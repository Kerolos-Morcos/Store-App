class RatingModel
{
  final dynamic rate;
  final dynamic count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(jsonData){
    return RatingModel(
      rate: jsonData['rate'],
      count: jsonData['count'],
    );
  }
}