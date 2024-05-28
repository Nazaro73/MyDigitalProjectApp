import 'package:dio/dio.dart';
import '../models/User.dart'; // Assurez-vous que le chemin d'importation est correct


class UserService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.20.10.3:3000/user",
    connectTimeout: Duration(milliseconds: 5000),
    // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),
    // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // Ajout de la fonction pour chercher des utilisateurs par nom avec une limite de 10
  Future<List<User>> searchUsersByName(String name) async {
    try {
      final response = await _dio.get('/search', queryParameters: {'name': name});
      if (response.statusCode == 200) {
        // Convertit les données reçues en une liste d'objets User
        return (response.data as List).map((user) =>
            User.fromJson(user as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      throw Exception('Error fetching users: $e et $stacktrace');
    }
  }

  Future<List<User>> getMyFriends(int myId) async {
    try {
      final response = await _dio.get('/friends/$myId');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((user) => User.fromJson(user as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load Users for Voyage: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      throw Exception('Error fetching Users for Voyage: $e et $stacktrace');
    }
  }

  

  Future<User> getMyProfile(String ville) async {
    try {
      final response = await _dio.get('/me');
      if (response.statusCode == 200) {
        return User.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load User: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      throw Exception('Error fetching User: $e et $stacktrace');
    }
  }
}
