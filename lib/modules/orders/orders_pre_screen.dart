import 'dart:async';

import 'package:cashier_app/modules/orders/confirmed_order_screen.dart';
import 'package:cashier_app/modules/orders/on_the_way.dart';
import 'package:cashier_app/shared/components/components.dart';
import 'package:cashier_app/shared/styles/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:cashier_app/models/order_model.dart';
import 'package:cashier_app/modules/orders/order_cubit.dart';
import 'package:cashier_app/modules/orders/order_screen.dart';
import 'package:cashier_app/modules/orders/order_states.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class OrdersPreScreen extends StatefulWidget {
  const OrdersPreScreen({super.key});

  @override
  State<OrdersPreScreen> createState() => _OrdersPreScreenState();
}

int selectedItemIndex = 0;

class _OrdersPreScreenState extends State<OrdersPreScreen> {
  final pageController = PageController();
  TextEditingController minutesController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  StreamSubscription<DatabaseEvent>? _isBusySubscription;
  StreamSubscription<DatabaseEvent>? _isBusyTimeSubscription;

  int currentMinute = 0;
  int currentSecond = 0;
  bool isCountDown = true;

  @override
  void initState() {
    _isBusyTimeSubscription = FirebaseDatabase.instance
        .ref()
        .child('busyTime')
        .onValue
        .listen((event) {
      if (event.snapshot.value != 0) {
        setState(() {
          currentMinute = event.snapshot.value as int;
        });
      }
    });

    _isBusySubscription =
        FirebaseDatabase.instance.ref().child('busy').onValue.listen((event) {
      if (event.snapshot.value == true) {
        setState(() {
          isCountDown = true;
        });
      } else if (event.snapshot.value == false) {
        setState(() {
          isCountDown = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference pendingOrders =
        FirebaseDatabase.instance.ref().child('orders');

    Future<bool> ispendingOrdersEmpty() async {
      DataSnapshot snapshot = await pendingOrders.get();
      return snapshot.value == null;
    }

    DatabaseReference beingPreparedOrders =
        FirebaseDatabase.instance.ref().child('preparingOrders');

    Future<bool> isBeingPreparedOrdersEmpty() async {
      DataSnapshot snapshot = await beingPreparedOrders.get();
      return snapshot.value == null;
    }

    DatabaseReference onTheWayOrders =
        FirebaseDatabase.instance.ref().child('onTheWayOrders');

    Future<bool> isOnTheWayOrdersEmpty() async {
      DataSnapshot snapshot = await onTheWayOrders.get();
      return snapshot.value == null;
    }

  void showBusyAlertDialog(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => SizedBox(
      child: Material(
        color: Colors.transparent, // Makes the background transparent
        child: SizedBox(
          height: 200,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Busy For How Long?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            content: Form(
              key: formkey,
              child: defaultForm(
                controller: minutesController,
                type: TextInputType.number,
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Time';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    FirebaseDatabase.instance
                        .ref()
                        .child('busyTime')
                        .set(int.tryParse(minutesController.text) ?? 0);
                    FirebaseDatabase.instance.ref().child('busy').set(true);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    color: primaryOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
    String pizzaId = '';
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              drawer: SizedBox(
                width: MediaQuery.of(context).size.width / 1.3,
                child: Drawer(
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'Avaliable or Busy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        button(
                          height: 50,
                          function: () {
                            showBusyAlertDialog(
                              context,
                            );
                          },
                          text: 'busy',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        outlinedButton(
                            height: 50,
                            function: () {
                              FirebaseDatabase.instance
                                  .ref()
                                  .child('busyTime')
                                  .set(0);
                              FirebaseDatabase.instance
                                  .ref()
                                  .child('busy')
                                  .set(false);
                            },
                            text: 'Avaliable'),
                        const SizedBox(
                          height: 30,
                        ),
                        isCountDown == true
                            ? Column(
                                children: [
                                  const Text(
                                    'Busy Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TimerCountdown(
                                      onTick: (remainingTime) {
                                        FirebaseDatabase.instance
                                            .ref()
                                            .child('busyTime')
                                            .set(remainingTime.inMinutes);
                                      },
                                      timeTextStyle: const TextStyle(
                                        color: priceColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                      spacerWidth: 1,
                                      enableDescriptions: false,
                                      format:
                                          CountDownTimerFormat.minutesSeconds,
                                      endTime: DateTime.now().add(
                                        Duration(
                                          minutes: currentMinute,
                                          seconds: 59,
                                        ),
                                      ))
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              appBar: AppBar(title: const SizedBox()),
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomHeadingItem(
                    pageController: pageController,
                    selectedItemIndex: selectedItemIndex,
                    onItemSelected: (index) {
                      setState(() {
                        selectedItemIndex = index;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (value) {
                        if (value == 0) {
                          setState(() {
                            selectedItemIndex = 0;
                          });
                        } else if (value == 1) {
                          setState(() {
                            selectedItemIndex = 1;
                          });
                        } else if (value == 2) {
                          setState(() {
                            selectedItemIndex = 2;
                          });
                        }
                      },
                      controller: pageController,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return FutureBuilder<bool>(
                            future: ispendingOrdersEmpty(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (snapshot.data == true) {
                                  return const Center(
                                    child: Text('No Pending Orders'),
                                  );
                                } else {
                                  return FirebaseAnimatedList(
                                      shrinkWrap: true,
                                      query: pendingOrders,
                                      itemBuilder: (context, snapshot,
                                          animation, index) {
                                        Map orders = snapshot.value as Map;
                                        orders['key'] = snapshot.key;

                                        if (orders.containsKey('pizzas')) {
                                          Map<dynamic, dynamic> pizzas =
                                              orders['pizzas'];
                                          pizzas.forEach(
                                              (pizzaKey, pizzaDetails) {
                                            if (pizzaDetails
                                                .containsKey('id')) {
                                              pizzaId = pizzaDetails['id'];
                                              print(
                                                  'Pizza ID from orderData: $pizzaId');
                                            } else {
                                              print(
                                                  'Pizza ID not found in pizza details');
                                            }
                                          });
                                        } else {
                                          print('No pizzas found in orderData');
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => OrderScreen(
                                                  orders_Key: orders['key'],
                                                  pizzas_Key: pizzaId,
                                                ),
                                              ),
                                            );
                                            print(orders['key']);
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                tileColor: Colors.indigo[100],
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[900],
                                                  ),
                                                  onPressed: () {
                                                    pendingOrders
                                                        .child(orders['key'])
                                                        .remove();
                                                  },
                                                ),
                                                leading: SizedBox(
                                                    width: 50,
                                                    child:
                                                        Text(orders['name'])),
                                                title: Text(
                                                  orders['userName'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  orders['phone'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                          );
                        }
                        if (index == 1) {
                          return FutureBuilder<bool>(
                            future: isBeingPreparedOrdersEmpty(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (snapshot.data == true) {
                                  return const Center(
                                    child: Text('No Confirmed Orders'),
                                  );
                                } else {
                                  return FirebaseAnimatedList(
                                      shrinkWrap: true,
                                      query: beingPreparedOrders,
                                      itemBuilder: (context, snapshot,
                                          animation, index) {
                                        Map orders = snapshot.value as Map;
                                        orders['key'] = snapshot.key;

                                        if (orders.containsKey('pizzas')) {
                                          Map<dynamic, dynamic> pizzas =
                                              orders['pizzas'];
                                          pizzas.forEach(
                                              (pizzaKey, pizzaDetails) {
                                            if (pizzaDetails
                                                .containsKey('id')) {
                                              pizzaId = pizzaDetails['id'];
                                              print(
                                                  'Pizza ID from orderData: $pizzaId');
                                            } else {
                                              print(
                                                  'Pizza ID not found in pizza details');
                                            }
                                          });
                                        } else {
                                          print('No pizzas found in orderData');
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    ConfirmedOrderScreen(
                                                  orders_Key: orders['key'],
                                                  pizzas_Key: pizzaId,
                                                ),
                                              ),
                                            );
                                            print(orders['key']);
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                tileColor: Colors.indigo[100],
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[900],
                                                  ),
                                                  onPressed: () {
                                                    beingPreparedOrders
                                                        .child(orders['key'])
                                                        .remove();
                                                  },
                                                ),
                                                leading: SizedBox(
                                                    width: 50,
                                                    child:
                                                        Text(orders['name'])),
                                                title: Text(
                                                  orders['userName'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  orders['phone'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                          );
                        }
                        if (index == 2) {
                          return FutureBuilder<bool>(
                            future: isOnTheWayOrdersEmpty(),
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (snapshot.data == true) {
                                  return const Center(
                                    child: Text('No On The Way Orders'),
                                  );
                                } else {
                                  return FirebaseAnimatedList(
                                      shrinkWrap: true,
                                      query: onTheWayOrders,
                                      itemBuilder: (context, snapshot,
                                          animation, index) {
                                        Map orders = snapshot.value as Map;
                                        orders['key'] = snapshot.key;

                                        if (orders.containsKey('pizzas')) {
                                          Map<dynamic, dynamic> pizzas =
                                              orders['pizzas'];
                                          pizzas.forEach(
                                              (pizzaKey, pizzaDetails) {
                                            if (pizzaDetails
                                                .containsKey('id')) {
                                              pizzaId = pizzaDetails['id'];
                                              print(
                                                  'Pizza ID from orderData: $pizzaId');
                                            } else {
                                              print(
                                                  'Pizza ID not found in pizza details');
                                            }
                                          });
                                        } else {
                                          print('No pizzas found in orderData');
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    OnTheWayOrderScreen(
                                                  orders_Key: orders['key'],
                                                  pizzas_Key: pizzaId,
                                                ),
                                              ),
                                            );
                                            print(orders['key']);
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                tileColor: Colors.indigo[100],
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[900],
                                                  ),
                                                  onPressed: () {
                                                    pendingOrders
                                                        .child(orders['key'])
                                                        .remove();
                                                  },
                                                ),
                                                leading: SizedBox(
                                                    width: 50,
                                                    child:
                                                        Text(orders['name'])),
                                                title: Text(
                                                  orders['userName'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  orders['phone'],
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              }
                            },
                          );
                        }
                        return null;
                      },
                      itemCount: 3,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // Widget buildOrderDetails(BuildContext context,
  Widget buildOrder(BuildContext context, OrderItemModel order) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${order.counter}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${order.price}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${order.addedToppings}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomHeadingItem extends StatefulWidget {
  final PageController pageController;

  final int selectedItemIndex; // Add this field
  final ValueChanged<int> onItemSelected;

  const CustomHeadingItem({
    super.key,
    required this.pageController,
    required this.selectedItemIndex,
    required this.onItemSelected,
  });

  @override
  _CustomHeadingItemState createState() => _CustomHeadingItemState();
}

class _CustomHeadingItemState extends State<CustomHeadingItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedItemIndex = 0;
                    });
                    widget.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text(
                          maxLines: 2,
                          'Pending Orders',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 4,
                        width: double.infinity,
                        color: selectedItemIndex == 0
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedItemIndex = 1;
                    });
                    widget.pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text(
                          maxLines: 2,
                          'Preparing Orders',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 4,
                        width: double.infinity,
                        color: selectedItemIndex == 1
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedItemIndex = 2;
                    });
                    widget.pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text(
                          maxLines: 2,
                          'Confirmed Orders',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 4,
                        width: double.infinity,
                        color: selectedItemIndex == 2
                            ? Colors.orange
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
