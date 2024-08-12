import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_products_service.dart';

part 'get_commerce_state.dart';

class GetCommerceCubit extends Cubit<GetCommerceState> {
  final GetAllProductsService productService;
  List<ProductModel> products = [];
  List<ProductModel> displayedProducts = [];
  List<String> activeFilters = [];
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
      emit(GetCommerceFailure('cannot fetch products due to Network Issues ! \n$e'));
    }
  }

  void toggleFavoriteStatus(int id) {
    favoriteStatus[id] = !favoriteStatus[id]!;
    emit(GetCommerceSuccess(displayedProducts, favoriteStatus));
    // updating favorites and icon
  }

  void updateProducts(List<ProductModel> products) {
    emit(GetCommerceSuccess(products, favoriteStatus));
    // for updating products list
  }

  // for applying filter
  void applyFilter(List<String> categories) {
    activeFilters = categories;
    if (categories.isEmpty) {
      displayedProducts = List.from(products);
    } else {
      displayedProducts = products.where((product) {
        return activeFilters.contains(product.category);
      }).toList();
    }
    emit(GetCommerceSuccess(displayedProducts, favoriteStatus));
    // we update UI depending on categories, using emit()
    // we put this function here coz we update product list
  }

  // for deleting product by id
  void deleteProduct(int id) {
    products.removeWhere((product) => product.id == id);
    // Reapply the filter to ensure displayedProducts remains filtered if necessary
    applyFilter(activeFilters);
    favoriteStatus.remove(id);
    emit(GetCommerceSuccess(displayedProducts, favoriteStatus));
  }

  // for updating a product
  void refreshProduct(ProductModel updatedProduct) {
    // Update the main products list
    products = products.map((product) {
      if (product.id == updatedProduct.id) {
        // Preserving the favorite status when updating the product
        bool isFavorite = favoriteStatus[product.id] ?? false;
        favoriteStatus[updatedProduct.id] = isFavorite;
        return updatedProduct;
      }
      return product;
    }).toList();
    // Reapply the filter to ensure displayedProducts remains filtered if necessary
    applyFilter(activeFilters);
  }
}
