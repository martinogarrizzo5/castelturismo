class Itinerario {
  final int id;
  final String descrizione;
  final int ore;

  Itinerario({
    required this.id,
    required this.descrizione,
    required this.ore,
  });

  factory Itinerario.fromJson(Map<String, dynamic> json) {
    return Itinerario(
      id: json["id"],
      descrizione: json["descrizione"],
      ore: json["ore"],
    );
  }
}
