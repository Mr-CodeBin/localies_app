import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localies_app/providers/store_provider.dart';
import 'package:localies_app/screens/map_page.dart';
import 'package:localies_app/widgets/store_list_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.blue,
        title: const Text(
          'Store Locator',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Stores',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                storeProvider.filterStores(value);
                //keyboard focus will be removed
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                storeProvider.filterStores(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 50),
              physics: const BouncingScrollPhysics(),
              itemCount: storeProvider.stores.length,
              itemBuilder: (context, index) {
                final store = storeProvider.stores[index];
                return StoreListCard(
                    key: ValueKey(store.longitude), store: store);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement map navigation
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MapPage(),
            ),
          );
        },
        child: const Icon(Icons.phone_iphone_outlined),
      ),
    );
  }
}
