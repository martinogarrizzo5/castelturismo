import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/utils/download.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Favorites with ChangeNotifier {
  List<Dimora>? _places;

  List<Dimora>? get places {
    if (_places != null) {
      return [..._places!];
    }
    return null;
  }

  void togglePlace(Dimora place) {
    if (_places == null) return;

    int placeIndex = _places!.indexWhere((element) => element.id == place.id);

    if (placeIndex == -1) {
      _places!.add(place);
    } else {
      _places!.removeAt(placeIndex);
    }

    List<String> ids = _places!.map((place) => place.id.toString()).toList();
    SharedPreferences.getInstance()
        .then((sharedPrefs) => sharedPrefs.setStringList("favorites", ids));

    notifyListeners();
  }

  bool containsPlace(int id) {
    if (_places != null) {
      return _places!.indexWhere((element) => element.id == id) != -1;
    }

    return false;
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList("favorites");
    String formattedIds = "";
    if (items != null) {
      for (var item in items) {
        if (formattedIds.isEmpty) {
          formattedIds += item;
        } else {
          formattedIds += "+$item";
        }
      }
    }

    if (formattedIds.isNotEmpty) {
      List<Dimora> dimore = await Download.getFavoriteDimore(formattedIds);
      _places = dimore;
    } else {
      _places = [];
    }

    print("Loaded favorites");
    notifyListeners();
  }
}
