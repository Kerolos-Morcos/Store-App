part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<String> categories;
  GetCategoriesSuccess(this.categories);
}
