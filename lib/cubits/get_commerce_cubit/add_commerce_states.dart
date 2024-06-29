class UpdateCommerceStates {}

class NoCommerceState extends UpdateCommerceStates{}

class CommerceLoadedState extends UpdateCommerceStates{}

class CommerceFailureState extends UpdateCommerceStates{
  String errorMessage;
  CommerceFailureState({this.errorMessage = 'Error updating product'});
}
