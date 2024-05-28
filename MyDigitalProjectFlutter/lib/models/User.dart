class User {
  final int id;
  final String name;
  final String email;
  final String password; // Note: le mot de passe ne devrait jamais être stocké ou transmis en clair.
  final String img;
  final String gender;
  final DateTime birthdate;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.img,
    required this.birthdate
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['display_name'],
      email: json['email'],
      password: json['password'],
      img: json['img'],
      gender: json['gender'],
      birthdate: DateTime.parse(json['birthdate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password, // Assurez-vous d'utiliser une approche sécurisée
      'img_user': img,
      'gender': gender,
      'birthdate': birthdate,
    };
  }
}
