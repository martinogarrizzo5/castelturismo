import 'package:castelturismo/models/credits.dart';
import 'package:castelturismo/models/dimora.dart';
import 'package:castelturismo/models/filtro.dart';
import 'package:castelturismo/models/itinerario.dart';
import 'package:castelturismo/models/percorso.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/zona.dart';

class Download {
  static Future<Zona> getDimore({required int idZona}) async {
    Zona data;

    var url = Uri.parse(
        "http://prolococasteo.altervista.org/index.php/zona?zona=$idZona");

    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      final Zona zona = Zona.fromJson(extractedData);
      data = zona;
    } catch (err) {
      rethrow;
    }

    return data;
  }

  //TODO: SHOULD RETURN ZONA??
  static Future<List<Dimora>> getFilteredDimore(
      {required int idZona, required String filters}) async {
    List<Dimora> dimore = [];

    var url = Uri.parse(
        "http://prolococasteo.altervista.org/index.php/filtro?filtro=$filters&zona=$idZona");

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

  static Future<List<Itinerario>> getPercorsi() async {
    List<Itinerario> percorsi = [];

    final url =
        Uri.parse("http://prolococasteo.altervista.org/index.php/percorsi");
    try {
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List<dynamic>;
      List<Itinerario> extractedPercorsi =
          extractedData.map((e) => Itinerario.fromJson(e)).toList();
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

  static Future<List<Dimora>> getFavoriteDimore(String formattedIds) async {
    List<Dimora> dimore = [];
    try {
      final url = Uri.parse(
          "https://prolococasteo.altervista.org/index.php/dimore?dimore=$formattedIds");
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

  static Future<Percorso>? getPercorso(int id) async {
    Percorso? percorso;
    try {
      final url = Uri.parse(
          "https://prolococasteo.altervista.org/index.php/percorso?id=$id");
      var response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      percorso = Percorso.fromJson(extractedData);
    } catch (err) {
      print(err);
      rethrow;
    }

    return percorso;
  }
}
