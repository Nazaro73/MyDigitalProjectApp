import 'package:dio/dio.dart';
import '../models/User.dart'; // Assurez-vous que le chemin d'importation est correct


class SocialService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.20.10.3:3000/service",
    connectTimeout: Duration(milliseconds: 5000),
    // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),
    // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // Ajouter un nouvel ami en utilisant deux IDs de type int
  Future<void> addFriend(int idUser1, int idUser2) async {
    try {
      final response = await _dio.post('/amis', data: {
        'id_user1': idUser1,
        'id_user2': idUser2
      });
      if (response.statusCode != 201) {
        throw Exception("Failed to add friend with status: ${response.statusCode}");
      }
    } on DioError catch (e) {
      // Gestion des erreurs liées à Dio
      throw Exception("Failed to add friend: ${e.message}");
    } catch (e) {
      // Gestion d'autres types d'erreurs
      throw Exception("An unexpected error occurred: ${e.toString()}");
    }
  }
}
