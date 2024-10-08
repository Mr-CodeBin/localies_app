import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListCard extends StatelessWidget {
  final Product product;

  const ProductListCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: Text("\$${product.price}"),
      subtitle: Text(product.availability ? "Available" : "Out of stock"),
    );
  }
}
