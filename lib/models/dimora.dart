import 'package:castelturismo/utils/text.dart';
import 'package:flutter/cupertino.dart';
import './foto.dart';

class Dimora {
  final int id;
  final String? zona;
  final String via;
  final String nome;
  final String numero;
  final String? descrizione;
  final String tipologia;
  final List<Foto> foto;
  final String placeholderImage =
      "https://cdn.pixabay.com/photo/2012/02/28/10/22/background-18176_960_720.jpg";

  Dimora({
    required this.id,
    this.zona,
    required this.via,
    required this.nome,
    required this.numero,
    this.descrizione,
    required this.tipologia,
    required this.foto,
  });

  factory Dimora.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawPhotos = json["foto"];
    List<Foto> foto = rawPhotos.map((item) => Foto.fromJson(item)).toList();

    return Dimora(
        id: json["id"],
        via: json["via"],
        nome: json["nome"],
        numero: json["numero"],
        descrizione: json["descrizione"],
        tipologia: json["tipologia"],
        foto: foto,
        zona: json["zona"]);
  }

  String get coverPath {
    String cover = placeholderImage;

    for (var f in foto) {
      if (f.copertina == 1) {
        cover = f.path;
      }
    }

    return cover;
  }

  String get backgroundPath {
    String background = placeholderImage;

    for (var f in foto) {
      if (f.copertina == 2) {
        background = f.path;
      }
    }

    return background;
  }

  List<String> get generalPhotosPaths {
    List<String> photos = [];

    for (var f in foto) {
      if (f.copertina != 2 && f.copertina != 1) {
        photos.add(f.path);
      }
    }

    return photos;
  }

  String get mainGeneralPhoto {
    String photo = placeholderImage;

    if (generalPhotosPaths.isNotEmpty) {
      photo = generalPhotosPaths[0];
    }

    return photo;
  }

  String introDescription(BuildContext context) {
    String description = TextUtils.getText(descrizione!, context);

    int firstSentenceEndPos = description.indexOf(".", 15);
    // prevent error if end of sentence not found
    if (firstSentenceEndPos == -1) firstSentenceEndPos = description.length - 1;

    return "${description.substring(0, firstSentenceEndPos)}...";
  }

  String description(BuildContext context) {
    String description = TextUtils.getText(descrizione!, context);

    return description;
  }
}
