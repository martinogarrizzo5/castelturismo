import 'package:castelturismo/models/dimora.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Favorites with ChangeNotifier {
  List<Dimora> _places = [];

  List<Dimora> get places {
    return [..._places];
  }

  void togglePlace(Dimora place) {
    int placeIndex = _places.indexWhere((element) => element.id == place.id);

    if (placeIndex == -1) {
      _places.add(place);
    } else {
      _places.removeAt(placeIndex);
    }

    notifyListeners();
  }

  bool containsPlace(int id) {
    return _places.indexWhere((element) => element.id == id) != -1;
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    // TODO: HOW TO SAVE DIMORE???
  }
}
