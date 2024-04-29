import 'user.dart';
import 'activite.dart';

class Voyage {
  final int id;
  final String destination;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int creator_id;  // Le créateur du voyage
  final double budget;
  final List<User> guests;  // Liste des invités du voyage
  final List<Activite> activites;  // Liste des activités du voyage

  Voyage({
    required this.id,
    required this.destination,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.creator_id,
    required this.budget,
    this.guests = const [],
    this.activites = const [],
  });

  Voyage copyWith({
    int? id,
    String? destination,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    int? creator_id,
    double? budget,
    List<User>? guests,
    List<Activite>? activites,
  }) {
    return Voyage(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      creator_id: creator_id ?? this.creator_id,
      budget: budget ?? this.budget,
      guests: guests ?? this.guests,
      activites: activites ?? this.activites,

    );
  }

  factory Voyage.fromJson(Map<String, dynamic> json) {
    return Voyage(
      id: json['id_voyage'],
      destination: json['destination'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      creator_id: json['creator_id'],
      budget: json['budget'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom_voyage': destination,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'budget': budget,
    };
  }
}
