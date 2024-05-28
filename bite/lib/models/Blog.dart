class Blog {
  final int id;
  final String image1;
  final String titre1;
  final String contenu1;
  final String image2;
  final String titre2;
  final String contenu2;
  final String image3;
  final String titre3;
  final String contenu3;
  final String image4;
  final String titre4;
  final String contenu4;
  final DateTime date;

  Blog({
    required this.id,
    required this.image1,
    required this.titre1,
    required this.contenu1,
    required this.image2,
    required this.titre2,
    required this.contenu2,
    required this.image3,
    required this.titre3,
    required this.contenu3,
    required this.image4,
    required this.titre4,
    required this.contenu4,
    required this.date,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id_blog'],
      image1: json['img1'],
      titre1: json['titre1'],
      contenu1: json['contenu1'],
      image2: json['img2'],
      titre2: json['titre2'],
      contenu2: json['contenu2'],
      image3: json['img3'],
      titre3: json['titre3'],
      contenu3: json['contenu3'],
      image4: json['img4'],
      titre4: json['titre4'],
      contenu4: json['contenu4'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img1': image1,
      'titre1': titre1,
      'contenu1': contenu1,
      'img2': image2,
      'titre2': titre2,
      'contenu2': contenu2,
      'img3': image3,
      'titre3': titre3,
      'contenu3': contenu3,
      'img4': image4,
      'titre4': titre4,
      'contenu4': contenu4,
      'date': date.toIso8601String(),
    };
  }
}
