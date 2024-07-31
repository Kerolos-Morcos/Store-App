import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_commerce_state.dart';

class AddCommerceCubit extends Cubit<AddCommerceState> {
  AddCommerceCubit() : super(AddCommerceInitial());
}
