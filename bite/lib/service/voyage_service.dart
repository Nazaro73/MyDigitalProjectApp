import 'package:dio/dio.dart';
import '../models/Voyage.dart';

class VoyageService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.20.10.3:3000/voyage",
    connectTimeout: Duration(milliseconds: 5000),  // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),  // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // Ajouter un nouveau voyage
  Future<Response> addVoyage(Map<String, dynamic> voyageData) async {
    try {
      final response = await _dio.post('/', data: voyageData);
      if (response.statusCode == 201) {
        print('Voyage ajouté avec succès: ${response.data}');
      } else {
        print('Échec de l\'ajout du voyage: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      print('Erreur lors de la connexion au serveur: $e');
      rethrow;
    }
  }

// Méthode pour récupérer les voyages d'un utilisateur
  Future<List<Voyage>> fetchUserVoyages() async {
    try {
      final response = await _dio.get('/creator/me/voyages');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data as List;
        return jsonData.map((data) => Voyage.fromJson(data as Map<String, dynamic>)).toList();

      } else {
        throw Exception('Failed to load voyages: ${response.statusCode}');
      }
    } catch (e , stacktrace) {
      throw Exception('Error fetching voyages: $e et $stacktrace');
    }
  }
  // Récupérer un voyage par ID
  Future<Voyage> getVoyageById(int id) async {
    try {
      final response = await _dio.get('/$id');
      if (response.statusCode == 200) {
        return Voyage.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load voyage: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      throw Exception('Error fetching voyage: $e et $stacktrace');
    }
  }


  Future<List<String>> getTagVoyage() async {
    try {
      final response = await _dio.get('/tags');
      if (response.statusCode == 200) {
        List<String> tags = List<String>.from(response.data.map((tag) => tag['nom_tag'])); // Transformation en liste de chaînes
        return tags;
      } else {
        throw Exception('Failed to load tags: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      throw Exception('Error fetching voyage tags: $e et $stacktrace');
    }
  }

  // Mettre à jour un voyage
  Future<void> updateVoyage(int id, Map<String, dynamic> updateData) async {
    try {
      final response = await _dio.put('/$id', data: updateData);
      if (response.statusCode == 200) {
        print('Voyage mis à jour avec succès');
      } else {
        print('Échec de la mise à jour du voyage');
      }
    } catch (e) {
      print('Erreur de mise à jour: $e');
    }
  }

  // Supprimer un voyage
  Future<void> deleteVoyage(String id) async {
    try {
      final response = await _dio.delete('/$id');
      if (response.statusCode == 200) {
        print('Voyage supprimé avec succès');
      } else {
        print('Échec de la suppression du voyage');
      }
    } catch (e) {
      print('Erreur lors de la suppression: $e');
    }
  }


}


