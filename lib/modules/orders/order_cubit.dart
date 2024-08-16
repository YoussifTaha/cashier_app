import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashier_app/models/order_model.dart';
import 'package:cashier_app/modules/orders/order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialStates());

  static OrderCubit get(context) => BlocProvider.of(context);

  List<OrderItemModel>? orderItems = [];

  List<OrderDetailsModel>? orderDetails = [];

  List<OrderDetailsModel>? orderPreDetails = [];

  String? orderId;

  Future<void> copyCartToOrders({
    required String uId,
    required String name,
    required String userName,
    required String phone,
    required String orderType,
    int? subTotal,
    required int totalPrice,
    int? tableNumber,
    int? deliveryFees,
    String? address,
    required String notificationToken,
  }) async {
    DatabaseReference ordersReference =
        FirebaseDatabase.instance.ref().child('orders');

    DatabaseReference newOrderReference = ordersReference.push();

    DatabaseReference cartReference =
        FirebaseDatabase.instance.ref().child('users').child(uId).child('cart');

    DataSnapshot cartSnapshot = await cartReference.get();

    Map<dynamic, dynamic> orderData = {
      'name': name,
      'tableNumber': tableNumber,
      'deliveryFees': deliveryFees,
      'address': address,
      'userName': userName,
      'phone': phone,
      'orderType': orderType,
      'subTotal': subTotal,
      'totalPrice': totalPrice,
      'pizzas': cartSnapshot.value,
    };

    await newOrderReference.set(orderData);

    cartReference.remove();

    QuerySnapshot cart = await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('cart')
        .get();

    for (var cartDoc in cart.docs) {
      cartDoc.reference.delete();
    }
  }

  Future<void> moveOrderToPreparingOrders({
    required String orderId,
  }) async {
    DatabaseReference ordersReference =
        FirebaseDatabase.instance.ref().child('orders');

    DatabaseReference confirmedOrdersReference =
        FirebaseDatabase.instance.ref().child('preparingOrders');

    DataSnapshot orderSnapshot = await ordersReference.child(orderId).get();

    if (orderSnapshot.value != null) {
      await confirmedOrdersReference.child(orderId).set(orderSnapshot.value);
      await confirmedOrdersReference
          .child(orderId)
          .update({'status': 'Being Prepared'});

      await ordersReference.child(orderId).remove();
    }
  }

  Future<void> movePreparingOrderToOnTheWaysOrders({
    required String orderId,
  }) async {
    DatabaseReference ordersReference =
        FirebaseDatabase.instance.ref().child('preparingOrders');

    DatabaseReference confirmedOrdersReference =
        FirebaseDatabase.instance.ref().child('onTheWayOrders');

    DataSnapshot orderSnapshot = await ordersReference.child(orderId).get();

    if (orderSnapshot.value != null) {
      await confirmedOrdersReference.child(orderId).set(orderSnapshot.value);
      await confirmedOrdersReference
          .child(orderId)
          .update({'status': 'On The Way'});

      await ordersReference.child(orderId).remove();
    }
  }
}
