class Activite {
  final int id;
  final String name;
  final String adresse;
  final double prix;

  Activite({
    required this.id,
    required this.name,
    required this.adresse,
    required this.prix,

  });

  factory Activite.fromJson(Map<String, dynamic> json) {
    return Activite(
      id: json['id'],
      name: json['name'],
      adresse: json['adresse'],
      prix: json['prix'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adresse': adresse,
      'prix': adresse,
    };
  }
}
