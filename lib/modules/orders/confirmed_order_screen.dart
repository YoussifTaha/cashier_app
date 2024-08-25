// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:cashier_app/shared/components/components.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashier_app/modules/orders/order_cubit.dart';
import 'package:cashier_app/modules/orders/order_states.dart';

class ConfirmedOrderScreen extends StatefulWidget {
  final String orders_Key;
  final String pizzas_Key;

  const ConfirmedOrderScreen({
    super.key,
    required this.orders_Key,
    required this.pizzas_Key,
  });

  @override
  State<ConfirmedOrderScreen> createState() => _ConfirmedOrderScreenState();
}

class _ConfirmedOrderScreenState extends State<ConfirmedOrderScreen> {
  DatabaseReference? db;
  late DatabaseReference pizzaDb;
  String? clientName;
  String? clientPhone;
  String? clientAddress;
  String? orderType;
  String? instructions;
  String? lang;
  int? tableNumber;
  int? subTotal;
  int? Total;
  int? deliveryFees;
  String itemName = '';
  String pizzaCrust = '';
  String itemSize = '';
  String itemCombo = '';
  String itemSpicy = '';
  // String itemComments = '';
  int? itemCount;
  int itemPrice = 0;
  Map<dynamic, dynamic>? orders;
  Map<dynamic, dynamic>? pizza;

  TextEditingController cancelOrderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = FirebaseDatabase.instance.ref().child('preparingOrders');

    pizzaDb = FirebaseDatabase.instance
        .ref()
        .child('preparingOrders')
        .child(widget.orders_Key)
        .child('pizzas');

    Orders_data();
  }

  @override
  void dispose() {
    cancelOrderController.dispose();
    super.dispose();
  }

  void Orders_data() async {
    DataSnapshot snapshot = await db!.child(widget.orders_Key).get();

    orders = snapshot.value as Map;

    // DataSnapshot pizzaSnapshot = await pizzaDb.child(widget.pizzas_Key).get();

    // pizza = pizzaSnapshot.value as Map;

    setState(() {
      clientName = orders?['userName'];
      clientPhone = orders?['phone'];
      clientAddress = orders?['address'];
      orderType = orders?['orderType'];
      tableNumber = orders?['tableNumber'];
      subTotal = orders?['subTotal'];
      Total = orders?['totalPrice'];
      deliveryFees = orders?['deliveryFees'];
      instructions = orders?['instructions'];
      lang = orders?['lang'];
      // itemName = pizza?['name'];
      // itemSize = pizza?['type'];
      // itemComments = pizza?['addedtoppings'];
      // itemCount = pizza?['counter'];
      // itemPrice = pizza?['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    showOverlay(BuildContext context) {
      OverlayState overlayState = Overlay.of(context);
      OverlayEntry? overlayEntry; // Declare as nullable

      void closeOverlay() {
        overlayEntry!.remove();
      }

      overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
              child: Container(
                color:
                    Colors.black.withOpacity(0.3), // Adjust opacity as needed
              ),
            ),
            GestureDetector(
              onTap: closeOverlay,
            ),
            Center(
              child: Container(
                width: 330,
                height: 220,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 30.0),
                  child: Column(
                    children: [
                      const Text(
                        'Order Canceling Reason',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8B8B8B),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.50,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        child: defaultForm(
                            border: const OutlineInputBorder(),
                            controller: cancelOrderController,
                            type: TextInputType.text),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                button(
                                    height: 40,
                                    function: () async {
                                      closeOverlay();
                                      Navigator.pop(context);
                                      var data = {
                                        'to': pizza?['notificationToken'],
                                        'priority': 'high',
                                        'notification': {
                                          'title': lang == 'ar'
                                              ? 'تم رفض طلبك'
                                              : 'Order Denied',
                                          'body': lang == 'ar'
                                              ? 'تم رفض طلبك بسبب'
                                              : 'Your order has been canceled due to ${cancelOrderController.text}',
                                        }
                                      };
                                      await http.post(
                                        Uri.parse(
                                            'https://fcm.googleapis.com/fcm/send'),
                                        body: jsonEncode(data),
                                        headers: {
                                          'Content-Type':
                                              'application/json; charset=UTF-8',
                                          'Authorization':
                                              'key=AAAAU-IJxXg:APA91bHirCRJJI0SN7MyDeOvveeRZvMZJ4FOXvHo1mF1Lch91S-ztMhiG3H_ER6DQYjRfkTG5LGaE7nbjJSZu04tJXvGtQ9D7S-wnQL9qceX2SENxkaXw5adZE5VGvC3vxd5I_kfuCPx'
                                        },
                                      );
                                      db?.child(widget.orders_Key).remove();
                                    },
                                    text: 'Cancel order')
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                outlinedButton(
                                    height: 40,
                                    function: () {
                                      closeOverlay();
                                    },
                                    text: 'BACK')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        opaque: false,
      );

      overlayState.insert(overlayEntry);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<OrderCubit, OrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'اسم العميل :    $clientName',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'رقم الهاتف  :    $clientPhone',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: clientAddress == 'null null'
                                      ? const EdgeInsets.symmetric(
                                          vertical: 0.0)
                                      : const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            clientAddress == 'null null'
                                                ? const SizedBox()
                                                : Text(
                                                    'العنوان       :   $clientAddress',
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: tableNumber == null
                                      ? const EdgeInsets.symmetric(
                                          vertical: 0.0)
                                      : const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            tableNumber == null
                                                ? const SizedBox(
                                                    height: 0,
                                                  )
                                                : Text(
                                                    'رقم الطاولة :  $tableNumber',
                                                    style: const TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ' نوع الطلب :    $orderType',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الصنف',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'الحجم',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'الكمية',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'السعر',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'التعليقات',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FirebaseAnimatedList(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            query: pizzaDb,
                            itemBuilder: (context, snapshot, animation, index) {
                              pizza = snapshot.value as Map;
                              pizza?['key'] = snapshot.key;

                              itemName = pizza?['name'];
                              pizzaCrust = pizza?['crust'];
                              itemSize = pizza?['type'] == null
                                  ? ''
                                  : '${pizza?['type']}';
                              itemCombo = pizza?['combo'] == 'No Combo'
                                  ? ''
                                  : pizza?['combo'] == null
                                      ? ''
                                      : 'Combo';
                              itemSpicy = pizza?['spicy'] == 'Regular'
                                  ? ''
                                  : pizza?['spicy'] == null
                                      ? ''
                                      : '${pizza?['spicy']}';
                              String addedToppings =
                                  pizza?['addedToppings'] == null
                                      ? ''
                                      : 'Extra ${pizza?['addedToppings']}';
                              String removedToppings =
                                  pizza?['removedToppings'] == null
                                      ? ''
                                      : 'Remove ${pizza?['removedToppings']}';

                              String itemComments =
                                  '$addedToppings $removedToppings';

                              itemCount = pizza?['counter'] ?? 1;
                              itemPrice = pizza?['price'];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$itemCombo $itemSpicy $pizzaCrust $itemName',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            itemSize,
                                            style: const TextStyle(
                                              fontSize: 14.0,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$itemCount',
                                            style: const TextStyle(
                                              fontSize: 14.0,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$itemPrice',
                                            style: const TextStyle(
                                              fontSize: 14.0,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            itemComments,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'التعليمات : $instructions',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'الاجمالي  :    $subTotal',
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: deliveryFees == null
                                      ? const EdgeInsets.symmetric(
                                          vertical: 0.0)
                                      : const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            deliveryFees == 0
                                                ? const SizedBox()
                                                : Text(
                                                    'التوصيل     :   $deliveryFees',
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'المجموع النهائي  :    $Total',
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  button(
                                      function: () async {
                                        OrderCubit.get(context)
                                            .movePreparingOrderToOnTheWaysOrders(
                                                orderId: widget.orders_Key);
                                        Navigator.pop(context);
                                        var data = {
                                          'to': pizza?['notificationToken'],
                                          'priority': 'high',
                                          'notification': {
                                            'title': lang == 'ar'
                                                ? 'الطلب في طريقه إليك'
                                                : 'The Order Is On Its Way To You',
                                            'body': lang == 'ar'
                                                ? 'إستمتع بوجبتك'
                                                : 'Enjoy Your Meal',
                                          }
                                        };
                                        await http.post(
                                          Uri.parse(
                                              'https://fcm.googleapis.com/fcm/send'),
                                          body: jsonEncode(data),
                                          headers: {
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                            'Authorization':
                                                'key=AAAAU-IJxXg:APA91bHirCRJJI0SN7MyDeOvveeRZvMZJ4FOXvHo1mF1Lch91S-ztMhiG3H_ER6DQYjRfkTG5LGaE7nbjJSZu04tJXvGtQ9D7S-wnQL9qceX2SENxkaXw5adZE5VGvC3vxd5I_kfuCPx'
                                          },
                                        );
                                      },
                                      text: 'confirm Order'),
                                ],
                              ),
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
