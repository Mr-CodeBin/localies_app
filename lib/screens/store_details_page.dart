import 'package:flutter/material.dart';
import 'package:localies_app/widgets/product_list_card.dart';
import '../models/store.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Store store;

  const StoreDetailsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Address: ${store.address}"),
            Text("Contact: ${store.contactNumber}"),
            Text("Opening Hours: ${store.openingHours}"),
            Text("Description: ${store.description}"),
            ElevatedButton(
              onPressed: () {
                // Implement call functionality
              },
              child: const Text("Call Store"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: store.products.length,
                itemBuilder: (context, index) {
                  final product = store.products[index];
                  return ProductListCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
