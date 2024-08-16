import 'package:cashier_app/models/search_model.dart';

abstract class AppStates {}

class AppInitialStates extends AppStates {}

class AppChangeBottomNabBarState extends AppStates {}

class AppChangeBottomNabBarItemsFillState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;

  AppGetUserErrorState(this.error);
}

class GetPizzaSuccessState extends AppStates {}

class GetPizzaErrorState extends AppStates {
  final String error;

  GetPizzaErrorState(this.error);
}

class GetToppingsSuccessState extends AppStates {}

class GetToppingsErrorState extends AppStates {
  final String error;

  GetToppingsErrorState(this.error);
}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {
  final List<SearchItemModel> searchModel;

  SearchSuccessState(this.searchModel);
}

class SearchErrorState extends AppStates {
  final String error;

  SearchErrorState(this.error);
}

// Events
abstract class PizzaEvent {}

class FetchSearchItemsEvent extends PizzaEvent {}

class SearchPizzaEvent extends PizzaEvent {
  final String query;

  SearchPizzaEvent(this.query);
}

class ScrollToOffersState extends AppStates {}

class ScrollToPizzasState extends AppStates {}

class ScrollToPastaState extends AppStates {}

class ScrollToSidesState extends AppStates {}

class ScrollToDrinksState extends AppStates {}

class RemoveAllCartState extends AppStates {}
