class Credits {
  final int id;
  final String descrizione;

  Credits({required this.id, required this.descrizione});

  factory Credits.fromJson(Map<String, dynamic> json) {
    return Credits(
      descrizione: json["descrizione"],
      id: json["id"],
    );
  }
}
