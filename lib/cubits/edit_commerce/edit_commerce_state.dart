part of 'edit_commerce_cubit.dart';

sealed class EditCommerceState {}

class EditCommerceInitial extends EditCommerceState {}

class EditCommerceLoading extends EditCommerceState {}

class EditCommerceSuccess extends EditCommerceState {
  final ProductModel product;

  EditCommerceSuccess(this.product);
}

class EditCommerceFailure extends EditCommerceState {
  final String error;

  EditCommerceFailure(this.error);
}
