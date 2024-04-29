import 'package:dio/dio.dart';

class VoyageService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.74:3000/voyage",
    connectTimeout: Duration(milliseconds: 5000),  // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),  // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // Ajouter un nouveau voyage
  Future<void> addVoyage(Map<String, dynamic> voyageData) async {
    final Map<String, dynamic> jsonData = {
      'email': "brasd@hotmail.com",
      'password': "123456789",
    };

    final connexion = await _dio.post('/login', data: jsonData);
    try {
      final response = await _dio.post('/', data: voyageData);
      if (response.statusCode == 201) {
        print('Voyage ajouté avec succès: ${response.data}');
      } else {
        print('Échec de l\'ajout du voyage: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la connexion au serveur: $e');
    }
  }
// Méthode pour récupérer les voyages d'un utilisateur
  Future<List<dynamic>> fetchUserVoyages() async {
    try {
      final response = await _dio.get('/users/me/voyages');
      if (response.statusCode == 200) {
        // Retourne la liste des voyages
        return response.data.map((v) => v['Voyage']).toList();
      } else {
        throw Exception('Failed to load voyages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching voyages: $e');
    }
  }
  // Récupérer un voyage par ID
  Future<void> getVoyageById(String id) async {
    try {
      final response = await _dio.get('/$id');
      if (response.statusCode == 200) {
        print('Détails du voyage: ${response.data}');
      } else {
        print('Erreur lors de la récupération du voyage: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur de réseau: $e');
    }
  }

  // Mettre à jour un voyage
  Future<void> updateVoyage(String id, Map<String, dynamic> updateData) async {
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

  // Ajouter un utilisateur à un voyage
  Future<void> addUserToVoyage(String idVoyage, String idUser) async {
    try {
      final response = await _dio.post('/$idVoyage/users', data: {
        'id_user': idUser
      });
      if (response.statusCode == 201) {
        print('Utilisateur ajouté avec succès: ${response.data}');
      } else {
        print('Échec de l\'ajout de l\'utilisateur: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'utilisateur: $e');
    }
  }
  // Supprimer un utilisateur d'un voyage
  Future<void> removeUserFromVoyage(String idVoyage, String idUser) async {
    try {
      final response = await _dio.delete('/$idVoyage/users/$idUser');
      if (response.statusCode == 200) {
        print('Utilisateur supprimé avec succès');
      } else {
        print('Échec de la suppression de l\'utilisateur: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la suppression de l\'utilisateur: $e');
    }
  }

  // Ajouter une activité à un voyage
  Future<void> addActivityToVoyage(String idVoyage, String idActivite) async {
    try {
      final response = await _dio.post('/$idVoyage/activites', data: {
        'id_activite': idActivite
      });
      if (response.statusCode == 201) {
        print('Activité ajoutée avec succès: ${response.data}');
      } else {
        print('Échec de l\'ajout de l\'activité: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'activité: $e');
    }
  }

  // Supprimer une activité d'un voyage
  Future<void> removeActivityFromVoyage(String idVoyage, String idActivite) async {
    try {
      final response = await _dio.delete('/$idVoyage/activites/$idActivite');
      if (response.statusCode == 200) {
        print('Activité supprimée avec succès');
      } else {
        print('Échec de la suppression de l\'activité: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la suppression de l\'activité: $e');
    }
  }

}


