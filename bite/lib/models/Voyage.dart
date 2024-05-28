import 'User.dart';  // Assuming User is defined in user.dart
import 'Activite.dart';  // Assuming Activite is defined in activite.dart

class Voyage {
  final int id;
  final String nomVoyage;
  final String lieux;
  final double budget;
  final DateTime startDate;
  final DateTime endDate;
  final int creatorId;
  final String img;
  final String tag;
  final List<User> guests;
  final List<Activite> activites;

  Voyage({
    required this.id,
    required this.nomVoyage,
    required this.lieux,
    required this.budget,
    required this.startDate,
    required this.endDate,
    required this.creatorId,
    required this.tag,
    required this.img,
    List<User>? guests,
    List<Activite>? activites,
  }) : guests = guests ?? [],
        activites = activites ?? [];

  Voyage copyWith({
    int? id,
    String? nomVoyage,
    String? lieux,
    double? budget,
    DateTime? startDate,
    DateTime? endDate,
    int? creatorId,
    String? img,
    String? tag,
    List<User>? guests,
    List<Activite>? activites,
  }) {
    return Voyage(
      id: id ?? this.id,
      nomVoyage: nomVoyage ?? this.nomVoyage,
      lieux: lieux ?? this.lieux,
      budget: budget ?? this.budget,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      creatorId: creatorId ?? this.creatorId,
      img: img ?? this.img,
      tag: tag ?? this.tag,
      guests: guests ?? this.guests,
      activites: activites ?? this.activites,
    );
  }

  factory Voyage.fromJson(Map<String, dynamic> json) {
    // Extraction sécurisée de la liste des activités, gère le cas où 'activites' est null
    var activitesList = json['activites'] as List? ?? [];
    List<Activite> activiteList = activitesList.map((dynamic item) => Activite.fromJson(item as Map<String, dynamic>)).toList();

    // Extraction sécurisée de la liste des invités, gère le cas où 'guests' est null
    var guestsList = json['guests'] as List? ?? [];
    List<User> guestList = guestsList.map((dynamic item) => User.fromJson(item as Map<String, dynamic>)).toList();

    return Voyage(
      id: json['id_voyage'] as int,
      nomVoyage: json['nom_voyage'] as String,
      lieux: json['lieux'] as String,
      budget: (json['budget'] as num).toDouble(),
      startDate: DateTime.parse(json['date_debut'] as String),
      endDate: DateTime.parse(json['date_fin'] as String),
      creatorId: json['creator_id'] as int,
      tag: json['tag'] as String,
      img: json['img'] as String,
      guests: guestList,
      activites: activiteList,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id_voyage': id,
      'nom_voyage': nomVoyage,
      'lieux': lieux,
      'budget': budget,
      'date_debut': startDate.toIso8601String(),
      'date_fin': endDate.toIso8601String(),
      'creator_id': creatorId,
      'img': img,
      'tag': tag,
      'guests': guests.map((user) => user.toJson()).toList(),
      'activites': activites.map((activite) => activite.toJson()).toList(),
    };
  }

  Map<String, dynamic> toJsonCreate() {
    return {
      'nom_voyage': nomVoyage,
      'lieux': lieux,
      'budget': budget,
      'date_debut': startDate.toIso8601String(),
      'date_fin': endDate.toIso8601String(),
      'creator_id': creatorId,
      'img': img,
      'tag': tag,
      'guests': guests.map((user) => user.toJson()).toList(),
      'activites': activites.map((activite) => activite.toJson()).toList(),
    };
  }
}
