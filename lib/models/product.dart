class Product {
  final String name;
  final String description;
  final double price;
  final bool availability;

  Product({
    required this.name,
    required this.price,
    required this.availability,
    this.description = '',
  });
}
