import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_commerce_state.dart';

class GetCommerceCubit extends Cubit<GetCommerceState> {
  GetCommerceCubit() : super(GetCommerceInitial());
}
