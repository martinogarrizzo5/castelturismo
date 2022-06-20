import './dimora.dart';

class Zona {
  final int id;
  final String? descrizione;
  final List<Dimora> dimore;

  Zona({
    required this.id,
    required this.descrizione,
    required this.dimore,
  });

  factory Zona.fromJson(Map<String, dynamic> json) {
    final dimore = json["dimore"] as List;

    List<Dimora> dimoreList = dimore.map((i) => Dimora.fromJson(i)).toList();

    return Zona(
      id: json["id"],
      descrizione: json["descrizione"],
      dimore: dimoreList,
    );
  }

  List<Dimora> get monumenti {
    List<Dimora> monumenti = [];
    for (var dimora in dimore) {
      if (dimora.tipologia != "Bar" &&
          dimora.tipologia != "Ristorante" &&
          dimora.tipologia != "Albergo") {
        monumenti.add(dimora);
      }
    }

    return monumenti;
  }

  List<Dimora> get bar {
    List<Dimora> bar = [];
    for (var dimora in dimore) {
      if (dimora.tipologia == "Bar" || dimora.tipologia == "Ristorante") {
        bar.add(dimora);
      }
    }

    return bar;
  }

  List<Dimora> get hotels {
    List<Dimora> hotels = [];
    for (var dimora in dimore) {
      if (dimora.tipologia == "Albergo") {
        hotels.add(dimora);
      }
    }

    return hotels;
  }
}
