import 'package:castelturismo/models/filtro.dart';
import 'package:castelturismo/utils/download.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class Filters with ChangeNotifier {
  List<Filtro>? _filters;

  List<Filtro>? get filters {
    if (_filters != null) {
      return [..._filters!];
    }

    return null;
  }

  Future<void> loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? items = prefs.getStringList("filters");
    items ??= []; // prevent null filters

    _filters = await Download.getFiltri();
    for (var item in items) {
      int index =
          _filters!.indexWhere((element) => element.id == int.parse(item));
      if (index != -1) {
        _filters![index].toggleCheck();
      }
    }

    notifyListeners();
  }

  String get formattedFiltersId {
    String ids = "";

    if (_filters != null) {
      for (var filter in _filters!) {
        if (filter.isChecked) {
          if (ids.isEmpty) {
            ids = "$ids${filter.id}";
          } else {
            ids = "$ids+${filter.id}";
          }
        }
      }
    }

    return ids;
  }
}
