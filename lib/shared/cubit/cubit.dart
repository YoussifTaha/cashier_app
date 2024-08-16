// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cashier_app/models/favorites_model.dart';
// import 'package:cashier_app/models/pizza_item_model.dart';
// import 'package:cashier_app/models/toppings_model.dart';

// import 'package:cashier_app/modules/orders/orders_pre_screen.dart';

// import 'package:cashier_app/shared/components/components.dart';
// import 'package:cashier_app/shared/cubit/states.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import '../../models/search_model.dart';
// import 'package:ionicons/ionicons.dart';

// class AppCubit extends Cubit<AppStates> {
//   AppCubit() : super(AppInitialStates()) {
//     // removeAllCart();
//   }

//   static AppCubit get(context) => BlocProvider.of(context);

//   // List<Widget> screens = [
//   //   const HomeScreen(),
//   //   const SearchScreen(),
//   //   MenuScreen(),
//   //   const OrdersPreScreen(),
//   //   const FavoritesScreen(),
//   // ];

//   List<BottomNavigationBarItem> bottomItems = [
//     const BottomNavigationBarItem(
//       activeIcon: Icon(Ionicons.home),
//       icon: Icon(Ionicons.home_outline),
//       label: 'Home',
//     ),
//     const BottomNavigationBarItem(
//       activeIcon: Icon(Icons.search),
//       icon: Icon(Icons.search),
//       label: 'Search',
//     ),
//     const BottomNavigationBarItem(
//       activeIcon: Icon(Icons.menu_book_outlined),
//       icon: Icon(Icons.menu_book),
//       label: 'Menu',
//     ),
//     const BottomNavigationBarItem(
//       activeIcon: Icon(Icons.notifications),
//       icon: Icon(Icons.notifications_none_outlined),
//       label: 'Notifications',
//     ),
//     const BottomNavigationBarItem(
//       activeIcon: Icon(Icons.favorite),
//       icon: Icon(Icons.favorite_outline),
//       label: 'Favorites',
//     ),
//   ];

//   List<String> titles = [
//     'Home',
//     'Search',
//     'Menu',
//     'Notifications',
//     'Profile',
//   ];

//   // void changeIndex(int index) {
//   //   currentIndex = index;
//   //   print(currentIndex);
//   //   emit(AppChangeBottomNabBarState());
//   // }

//   bool isDark = false;

//   // void changeAppMode({bool? fromShared}) {
//   //   if (fromShared != null) {
//   //     isDark = fromShared;
//   //   } else {
//   //     isDark = !isDark;
//   //   }
//   //   CashHelper.putData(key: 'isDark', value: isDark).then((value) {
//   //     emit(AppChangeModeState());
//   //   });
//   // }

//   // final String UID = FirebaseAuth.instance.currentUser!.uid;

//   List<PizzaItemModel> pizzaModel = [];

//   List<ToppingsModel> toppingsModel = [];

//   List<SearchItemModel> searchModel = [];
//   List<SearchItemModel> searchResults = [];

//   String userName = "";
//   String phone = "";

//   // void getUserName() {
//   //   FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(UID)
//   //       .get()
//   //       .then((DocumentSnapshot userSnapshot) {
//   //     userName = userSnapshot.get('userName');
//   //   });
//   // }

//   // void getUserPhone() {
//   //   FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(UID)
//   //       .get()
//   //       .then((DocumentSnapshot userSnapshot) {
//   //     phone = userSnapshot.get('phone');
//   //   });
//   // }

//   void getPizzaItem() {
//     FirebaseFirestore.instance.collection('pizzas').get().then((value) {
//       for (var element in value.docs) {
//         pizzaModel.add(PizzaItemModel.fromJson(element.data()));
//       }
//       emit(GetPizzaSuccessState());
//     }).catchError((error) {
     
//       emit(GetPizzaErrorState(error.toString()));
//     });
//   }

//   void getToppingsItem({required String name}) {
//     toppingsModel = [];
//     FavoritesItemModel favoritesItemModel = FavoritesItemModel(name: name);
//     FirebaseFirestore.instance
//         .collection('pizzas')
//         .doc(favoritesItemModel.name)
//         .collection('toppings')
//         .get()
//         .then((value) {
//       for (var element in value.docs) {
//         toppingsModel.add(ToppingsModel.fromJson(element.data()));
//       }
//       emit(GetToppingsSuccessState());
//     }).catchError((error) {
//       print(error);
//       emit(GetToppingsErrorState(error.toString()));
//     });
//   }

//   void getSearchItem() {
//     searchModel = [];
//     FirebaseFirestore.instance.collection('pizzas').snapshots().listen((event) {
//       searchModel = event.docs
//           .map((doc) => SearchItemModel.fromJson(doc.data()))
//           .toList();
//       emit(SearchLoadingState());
//     });
//   }

//   // New method to return Future<List<PizzaItemModel>> for the search results
//   Future<List<SearchItemModel>> searchItems(String searchQuery) async {
//     // Filter pizzaModel based on the searchQuery
//     List<SearchItemModel> searchResults = searchModel
//         .where((item) =>
//             item.name.toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();
//     return searchResults;
//   }

//   // void removeAllCart() async {
//   //   CollectionReference collectionReference = FirebaseFirestore.instance
//   //       .collection('users')
//   //       .doc(UID)
//   //       .collection('cart');
//   //   QuerySnapshot snapshot = await collectionReference.get();
//   //   for (DocumentSnapshot doc in snapshot.docs) {
//   //     await doc.reference.delete();
//   //   }
//   //   print('removed ya m3lm');
//   //   emit(RemoveAllCartState());
//   // }

//   final user = FirebaseAuth.instance.currentUser;

//   // void makeMedium() {
//   //   isFamilySize = false;
//   //   emit(MediumPizzaStates());
//   //   selectedPizzaSize = 'medium';
//   // }

//   // bool isOffer = false;
//   String scrollKey = 'offers';
//   bool offersActionTriggered = false;
//   bool pizzasActionTriggered = false;

//   void scrollToOffers() {
//     emit(ScrollToOffersState());
//     scrollKey = 'Offers';
//     offersActionTriggered = true;
//     pizzasActionTriggered = false;
//   }

//   void scrollToPizzas() {
//     emit(ScrollToPizzasState());
//     scrollKey = 'Pizzas';
//     offersActionTriggered = false;
//     pizzasActionTriggered = true;
//   }

//   void scrollToPasta() {
//     emit(ScrollToPastaState());
//     scrollKey = 'Pasta';
//   }

//   void scrollToSides() {
//     emit(ScrollToSidesState());
//     scrollKey = 'Sides';
//   }

//   void scrollToDrinks() {
//     emit(ScrollToDrinksState());
//     scrollKey = 'Drinks';
//   }

//   // Stream<AppStates> mapEventToState(PizzaEvent event) async* {
//   //   if (event is FetchSearchItemsEvent) {
//   //     yield SearchLoadingState(searchModel);
//   //     try { getSearchItem();} catch (error)
//   //     {
//   //       yield SearchErrorState('Failed to load pizzas');
//   //     }
//   //   } else if (event is SearchPizzaEvent) {
//   //     if (event.query.isEmpty){
//   //       yield SearchSuccessState(searchModel);
//   //     } else {
//   //       final filteredPizzas = searchModel.where((SearchItemModel){
//   //         return SearchItemModel.name.toLowerCase().contains(event.query.toLowerCase());
//   //       }).toList();
//   //       yield SearchSuccessState(filteredPizzas);
//   //     }
//   //     }
// }
