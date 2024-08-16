import 'package:cashier_app/models/order_model.dart';

abstract class OrderStates {}

class OrderInitialStates extends OrderStates {}

class AddToppingStates extends OrderStates {
  final int toppingsPrice;

  AddToppingStates(this.toppingsPrice);
}

class RemoveToppingStates extends OrderStates {
  final int toppingsPrice;

  RemoveToppingStates(this.toppingsPrice);
}

class AddToOrderState extends OrderStates {}

class OrderLoadedState extends OrderStates {
  final List<OrderItemModel>? orderItems;

  OrderLoadedState(this.orderItems);
}
