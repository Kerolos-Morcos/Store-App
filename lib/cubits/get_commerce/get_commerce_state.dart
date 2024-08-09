part of 'get_commerce_cubit.dart';

abstract class GetCommerceState {}

class GetCommerceInitial extends GetCommerceState {}

class GetCommerceLoading extends GetCommerceState {}

class GetCommerceSuccess extends GetCommerceState {
  final List<ProductModel> products;
  final Map<int, bool> favoriteStatus;

  GetCommerceSuccess(this.products, this.favoriteStatus);
}

class GetCommerceFailure extends GetCommerceState {
  final String errorMessage;

  GetCommerceFailure(this.errorMessage);
}
