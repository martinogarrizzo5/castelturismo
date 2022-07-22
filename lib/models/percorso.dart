import 'package:castelturismo/models/dimora.dart';

class Percorso {
  int id;
  int? durata;
  List<Dimora> dimore;

  Percorso({
    required this.id,
    required this.durata,
    required this.dimore,
  });

  factory Percorso.fromJson(Map<String, dynamic> json) {
    final rawDimore = json["dimore"] as List;
    List<Dimora> dimore = rawDimore.map((i) => Dimora.fromJson(i)).toList();

    return Percorso(
      id: json["id_percorso"],
      durata: json["durata"],
      dimore: dimore,
    );
  }
}
