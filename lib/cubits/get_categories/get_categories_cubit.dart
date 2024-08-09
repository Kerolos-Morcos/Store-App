import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/services/get_all_categories_service.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final GetAllCategoriesService categoriesService;
  GetCategoriesCubit(this.categoriesService) : super(GetCategoriesInitial());

  Future<void> fetchCategories() async {
    try {
      final categories = (await GetAllCategoriesService().getAllCategories()).cast<String>();
      emit(GetCategoriesSuccess(categories));
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }
}
