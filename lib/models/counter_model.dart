class CounterModel {
  late final int price;

  CounterModel({
    required this.price,

  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
    };
  }

  CounterModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }
}