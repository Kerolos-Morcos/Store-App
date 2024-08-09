import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_products_service.dart';

part 'get_commerce_state.dart';

class GetCommerceCubit extends Cubit<GetCommerceState> {
  final GetAllProductsService productService;
  List<ProductModel> products = [];
  List<ProductModel> displayedProducts = [];
  Map<int, bool> favoriteStatus = {};
  //  id   true

  GetCommerceCubit(this.productService) : super(GetCommerceInitial());

  Future<void> fetchAllProducts() async {
    try {
      emit(GetCommerceLoading());
      products = await productService.getAllProducts();
      displayedProducts = products;
      for (var product in products) {
        favoriteStatus[product.id] = false;
      }
      emit(GetCommerceSuccess(products, favoriteStatus));
    } catch (e) {
      emit(GetCommerceFailure('cannot fetch products due to Network Issues !'));
    }
  }

  void toggleFavoriteStatus(int id) {
    favoriteStatus[id] = !favoriteStatus[id]!;
    emit(GetCommerceSuccess(products, favoriteStatus));
    // updating favorites and icon
  }

  void updateProducts(List<ProductModel> products) {
    emit(GetCommerceSuccess(products, favoriteStatus));
    // for updating products list
  }

  // for applying filter
  void applyFilter(List<String> categories) {
    if (categories.isEmpty) {
      products = displayedProducts;
    } else {
      products = displayedProducts.where((product) {
        return categories.contains(product.category);
      }).toList();
    }
    // we update UI depending on categories, using emit()
    emit(GetCommerceSuccess(products, favoriteStatus));
    // we put this function here coz we update product list
  }

  // for deleting product by id
  void deleteProduct(int id) {
    products.removeWhere((product) => product.id == id);
    favoriteStatus.remove(id);
    emit(GetCommerceSuccess(products, favoriteStatus));
  }
}
