class CartItemModel {
  late String? username;
  late String? phone;
  late String? address;
  late int? tableNumber;
  late final String name;
  late final String image;
  late int? counter;
  late int? price;
  late String? type;
  late String? crust;
  late String? id;
  late String? cartRealTimeId;
  late List<dynamic>? addedToppings;
  late List<dynamic>? removedToppings;
  late List<String>? pizzaNames;
  late int? index;
  late int? subTotal;
  late int? deliveryFees;

  CartItemModel({
    this.username,
    this.phone,
    this.address,
    this.tableNumber,
    required this.name,
    required this.image,
    this.counter,
    this.price,
    this.type,
    this.crust,
    this.id,
    this.cartRealTimeId,
    this.addedToppings,
    this.removedToppings,
    this.pizzaNames,
    this.index,
    this.subTotal,
    this.deliveryFees,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'phone': phone,
      'address': address,
      'tableNumber': tableNumber,
      'name': name,
      'image': image,
      'counter': counter,
      'price': price,
      'type': type,
      'crust': crust,
      'id': id,
      'cartRealTimeId': cartRealTimeId,
      'addedToppings': addedToppings,
      'removedToppings': removedToppings,
      'pizzaNames': pizzaNames,
      'index': index,
      'subTotal': subTotal,
      'deliveryFees': deliveryFees,
    };
  }

  CartItemModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
    address = json['address'];
    tableNumber = json['tableNumber'];
    name = json['name'];
    counter = json['counter'];
    price = json['price'];
    type = json['type'];
    crust = json['crust'];
    image = json['image'];
    id = json['id'];
    cartRealTimeId = json['cartRealTimeId'];
    addedToppings = json['addedToppings'];
    removedToppings = json['removedToppings'];
    pizzaNames = json['pizzaNames'];
    index = json['index'];
    subTotal = json['subTotal'];
    deliveryFees = json['deliveryFees'];
  }
}
