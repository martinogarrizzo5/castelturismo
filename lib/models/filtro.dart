import 'package:castelturismo/providers/filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Filtro with ChangeNotifier {
  final int id;
  final String stato;
  bool isChecked = false;

  Filtro({required this.id, required this.stato});

  factory Filtro.fromJson(Map<String, dynamic> json) {
    return Filtro(
      id: json["id"],
      stato: json["stato"],
    );
  }

  void toggleCheck({BuildContext? context}) {
    isChecked = !isChecked;
    notifyListeners();

    if (context != null) {
      var filters = Provider.of<Filters>(context, listen: false).filters!;
      List<String> ids = [];
      for (var filter in filters) {
        if (filter.isChecked) {
          ids.add(filter.id.toString());
        }
      }
      SharedPreferences.getInstance().then(
        (sharedPrefs) => sharedPrefs.setStringList("filters", ids),
      );
    }
  }
}
