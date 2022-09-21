class Itinerario {
  final int id;
  final String descrizione;
  final int ore;
  final String imagePath;

  Itinerario({
    required this.id,
    required this.descrizione,
    required this.ore,
    required this.imagePath,
  });

  factory Itinerario.fromJson(Map<String, dynamic> json) {
    return Itinerario(
      id: json["id"],
      descrizione: json["descrizione"],
      ore: json["ore"],
      imagePath: json["path"],
    );
  }
}
