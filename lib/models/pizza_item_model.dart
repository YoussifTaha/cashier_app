class PizzaItemModel {
  late final String name;
  late final String image;
  late final int price;
  late final int priceLarge;
  late final int priceFamily;
  late int? updatedPrice;
  late int? pizzaCounter;
  late String? type;
  late String? crust;
  late String? cartId;
  late final int rating;
  late final String? ingredients;
  late List? pizzaToppings;
  late List? deletedPizzaToppings;

  late bool isFavorite;
  late int? index;

  PizzaItemModel({
    required this.name,
    required this.image,
    required this.price,
    required this.priceLarge,
    required this.priceFamily,
    required this.rating,
    this.pizzaCounter,
    this.updatedPrice,
    this.type,
    this.crust,
    this.cartId,
    this.ingredients,
    this.isFavorite = false,
    this.pizzaToppings,
    this.deletedPizzaToppings,
    this.index,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'priceLarge': priceLarge,
      'priceFamily': priceFamily,
      'pizzaCounter': pizzaCounter,
      'updatedPrice': updatedPrice,
      'type': type,
      'crust': crust,
      'cartId': cartId,
      'rating': rating,
      'ingredients': ingredients,
      'isFavorite': isFavorite,
      'pizzaToppings': pizzaToppings,
      'deletedPizzaToppings': deletedPizzaToppings,
      'index': index,
    };
  }

  PizzaItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    priceLarge = json['priceLarge'];
    priceFamily = json['priceFamily'];
    pizzaCounter = json['pizzaCounter'];
    updatedPrice = json['updatedPrice'];
    type = json['type'];
    crust = json['crust'];
    cartId = json['cartId'];
    rating = json['rating'];
    image = json['image'];
    ingredients = json['ingredients'];
    isFavorite = json['isFavorite'] ?? false;
    pizzaToppings = json['pizzaToppings'];
    deletedPizzaToppings = json['deletedPizzaToppings'];
    index = json['index'];
  }
}
