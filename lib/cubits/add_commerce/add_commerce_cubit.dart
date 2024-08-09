
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_commerce_state.dart';

class AddCommerceCubit extends Cubit<AddCommerceState> {
  AddCommerceCubit() : super(AddCommerceInitial());
}
