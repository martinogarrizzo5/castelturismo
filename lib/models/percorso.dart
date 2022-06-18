class Percorso {
  final int id;
  final String descrizione;
  final int ore;

  Percorso({
    required this.id,
    required this.descrizione,
    required this.ore,
  });

  factory Percorso.fromJson(Map<String, dynamic> json) {
    return Percorso(
      id: json["id"],
      descrizione: json["descrizione"],
      ore: json["ore"],
    );
  }
}
