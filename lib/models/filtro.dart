import 'package:castelturismo/providers/filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Provider.of<Filters>(context, listen: false).saveFilters();
    }
  }
}
