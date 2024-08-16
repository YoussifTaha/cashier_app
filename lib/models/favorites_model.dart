class FavoritesItemModel {
  late final String name;
  late final String? image;
  late final int? price;
  late final int? rating;
  late final String? ingredients;

  FavoritesItemModel({
    required this.name,
    this.image,
    this.price,
    this.rating,
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

  FavoritesItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    image = json['image'];
    ingredients = json['ingredients'];
  }
}