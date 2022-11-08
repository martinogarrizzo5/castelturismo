class IntroPercorso {
  final int id;
  final String descrizione;
  final int ore;
  final String imagePath;

  IntroPercorso({
    required this.id,
    required this.descrizione,
    required this.ore,
    required this.imagePath,
  });

  factory IntroPercorso.fromJson(Map<String, dynamic> json) {
    return IntroPercorso(
      id: json["id"],
      descrizione: json["descrizione"],
      ore: json["ore"],
      imagePath: json["path"],
    );
  }
}
