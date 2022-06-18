class Foto {
  final int id;
  final int dimora;
  final String path;
  final int copertina;

  Foto(this.id, this.dimora, this.path, this.copertina);

  Foto.fromJson(Map<String, dynamic> json)
      : copertina = json["copertina"],
        dimora = json["dimora"],
        id = json["id"],
        path = json["path"];
}
