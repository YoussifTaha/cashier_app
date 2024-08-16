class SearchItemModel {
  late final String name;
  late final String image;
  late final int price;
  late final int rating;
  late final String? ingredients;

  SearchItemModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    this.ingredients,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'rating': rating,
      'ingredients': ingredients,
    };
  }

  SearchItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    image = json['image'];
    ingredients = json['ingredients'];
  }
}