import 'package:castelturismo/models/credits.dart';
import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/models/filtro.dart';
import 'package:castelturismo/models/percorso.dart';
import 'package:castelturismo/providers/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/zona.dart';

class Download {
  static Future<Zona?> getDimore({int? id}) async {
    Zona? data;
    if (id != null) {
      var url = Uri.parse(
          "http://prolococasteo.altervista.org/index.php/zona?zona=$id");

      try {
        var response = await http.get(url);
        final extractedData = jsonDecode(response.body);
        final Zona zona = Zona.fromJson(extractedData);
        data = zona;
      } catch (err) {
        print(err);
        rethrow;
      }
    }

    return data;
  }

  //TODO: SHOULD RETURN ZONA??
  static Future<List<Dimora>> getFilteredDimore(BuildContext context) async {
    String formattedIds =
        Provider.of<Filters>(context, listen: false).formattedFiltersId;
    List<Dimora> dimore = [];

    // TODO: HOW THIS IS RELATED TO ZONA??
    var url = Uri.parse(
        "http://prolococasteo.altervista.org/index.php/filtro?filtro=$formattedIds");

    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List<dynamic>;

      for (var el in extractedData) {
        dimore.add(Dimora.fromJson(el));
      }
    } catch (err) {
      print(err);
      rethrow;
    }

    return dimore;
  }

  static Future<List<Percorso>> getPercorsi() async {
    List<Percorso> percorsi = [];

    final url =
        Uri.parse("http://prolococasteo.altervista.org/index.php/percorsi");
    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List<dynamic>;
      List<Percorso> extractedPercorsi =
          extractedData.map((e) => Percorso.fromJson(e)).toList();
      percorsi = extractedPercorsi;
    } catch (err) {
      print(err);
      rethrow;
    }
    return percorsi;
  }

  static Future<List<Filtro>> getFiltri() async {
    List<Filtro> filtri = [];

    final url =
        Uri.parse("https://prolococasteo.altervista.org/index.php/filtri");
    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List<dynamic>;
      List<Filtro> extractedPercorsi =
          extractedData.map((e) => Filtro.fromJson(e)).toList();
      filtri = extractedPercorsi;
    } catch (err) {
      print(err);
      rethrow;
    }
    return filtri;
  }

  static Future<List<Credits>> getCredits() async {
    List<Credits> credits = [];

    final url =
        Uri.parse("https://prolococasteo.altervista.org/index.php/credits");
    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List<dynamic>;
      List<Credits> extractedPercorsi =
          extractedData.map((e) => Credits.fromJson(e)).toList();
      credits = extractedPercorsi;
    } catch (err) {
      print(err);
      rethrow;
    }
    return credits;
  }
}
