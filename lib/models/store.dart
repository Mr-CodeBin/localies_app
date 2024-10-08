import 'package:localies_app/models/product.dart';

class Store {
  final String name;
  final String address;
  final String contactNumber;
  final String description;
  final String openingHours;
  final double latitude;
  final double longitude;
  final List<Product> products;
  bool isFavorite;

  Store({
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.description,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
    required this.products,
    this.isFavorite = false,
  });
}
