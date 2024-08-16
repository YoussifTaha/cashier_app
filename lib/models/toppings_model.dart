class ToppingsModel {
  late final String name;
  late final String image;
  late final int price;

  ToppingsModel({
    required this.name,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
    };
  }

  ToppingsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
  }
}

class UpdatedPriceModel {
  late final int counter;
  late final int stuffed;
  late final int price;

  UpdatedPriceModel({
    required this.counter,
    required this.stuffed,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
      'stuffed': stuffed,
      'price': price,
    };
  }

  UpdatedPriceModel.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    price = json['price'];
    stuffed = json['stuffed'];
  }
}
