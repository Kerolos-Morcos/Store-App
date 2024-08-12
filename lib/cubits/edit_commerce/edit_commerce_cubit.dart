import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product_service.dart';

part 'edit_commerce_state.dart';

class EditCommerceCubit extends Cubit<EditCommerceState> {
  final UpdateProductService updateProductService;

  EditCommerceCubit(this.updateProductService) : super(EditCommerceInitial());

  Future<void> updateProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
    required String id,
  }) async {
    emit(EditCommerceLoading());
    try {
      final ProductModel product = await updateProductService.updateProduct(
        title: title,
        price: price,
        description: description,
        image: image,
        category: category,
        id: id,
      );
      emit(EditCommerceSuccess(product));
    } catch (e) {
      emit(EditCommerceFailure(e.toString()));
    }
  }
}
