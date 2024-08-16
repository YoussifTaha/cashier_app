class OrderItemModel {
  late final String name;
  late String? image;
  late int? counter;
  late int? price;
  late String? type;
  late String? crust;
  late String? id;
  late List<dynamic>? addedToppings;
  late List<dynamic>? removedToppings;
  late List<String>? pizzaNames;

  OrderItemModel({
    required this.name,
    this.image,
    this.counter,
    this.price,
    this.type,
    this.crust,
    this.id,
    this.addedToppings,
    this.removedToppings,
    this.pizzaNames,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'counter': counter,
      'price': price,
      'type': type,
      'crust': crust,
      'id': id,
      'addedToppings': addedToppings,
      'removedToppings': removedToppings,
      'pizzaNames': pizzaNames,
    };
  }

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    counter = json['counter'];
    price = json['price'];
    type = json['type'];
    crust = json['crust'];
    image = json['image'];
    id = json['id'];
    addedToppings = json['addedToppings'];
    removedToppings = json['removedToppings'];
    pizzaNames = json['pizzaNames'];
  }
}

class OrderDetailsModel {
  late final String name;
  late String? userName;
  late String? phone;
  late String? orderType;
  late String? address;
  late int? tableNumber;
  late int? subTotal;
  late int? deliveryFees;
  late int? totalPrice;

  OrderDetailsModel({
    this.userName,
    this.phone,
    required this.name,
    this.orderType,
    this.address,
    this.tableNumber,
    this.subTotal,
    this.deliveryFees,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userName': userName,
      'phone': phone,
      'orderType': orderType,
      'address': address,
      'tableNumber': tableNumber,
      'subTotal': subTotal,
      'deliveryFees': deliveryFees,
      'totalPrice': totalPrice,
    };
  }

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userName = json['userName'];
    phone = json['phone'];
    orderType = json['orderType'];
    address = json['address'];
    tableNumber = json['tableNumber'];
    address = json['address'];
    subTotal = json['subTotal'];
    deliveryFees = json['deliveryFees'];
    totalPrice = json['totalPrice'];
  }
}
