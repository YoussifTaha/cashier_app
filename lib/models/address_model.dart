class AddressModel {
  late final String title;
  late String? area;
  late final String address;
  late bool isDefault;

  AddressModel({
    required this.title,
    this.area,
    required this.address,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'area': area,
      'address': address,
      'isDefault': isDefault,
    };
  }

  AddressModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    area = json['area'];
    address = json['address'];
    isDefault = json['isDefault'] ?? false;
    isDefault = json['isDefault'] ?? false;
  }
}
