import 'package:flutter/material.dart';
import 'package:localies_app/models/store.dart';
import 'package:localies_app/services/db_service.dart';

class StoreProvider extends ChangeNotifier {
  List<Store> _stores = [];
  List<Store> _filteredStores = [];

  List<Store> get stores => _filteredStores;

  StoreProvider() {
    fetchStores();
  }
  void fetchStores() async {
    _stores = await DbService.getStores();
    _filteredStores = _stores;
    notifyListeners();
  }

  void filterStores(String query) {
    if (query.isEmpty) {
      _filteredStores = _stores;
    } else {
      _filteredStores = _stores
          .where((store) =>
              store.name.toLowerCase().contains(query.toLowerCase()) ||
              store.address.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void toggleFavorite(Store store) {
    store.isFavorite = !store.isFavorite;
    notifyListeners();
  }

  List<Store> get favoriteStores =>
      _stores.where((store) => store.isFavorite).toList();
}
