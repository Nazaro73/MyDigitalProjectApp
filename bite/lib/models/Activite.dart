import 'dart:ffi';

class Activite {
  final int id;
  final String name;
  final String adresse;
  final num prix;
  final String ville;
  final String img;

  Activite({
    required this.id,
    required this.name,
    required this.adresse,
    required this.prix,
    required this.ville,
    required this.img
  });

  factory Activite.fromJson(Map<String, dynamic> json) {
    return Activite(
      id: json['id_activite'],
      name: json['nom_activite'],
      adresse: json['adresse_activite'],
      prix: json['prix_activite'],
      ville: json['ville'],
      img: json['img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_activite': id,
      'nom_activite': name,
      'adresse_activite': adresse,
      'prix_activite': prix,
      'ville': ville,
      'img': img,
    };
  }
}
