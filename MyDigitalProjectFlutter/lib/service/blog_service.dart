import 'package:dio/dio.dart';
import '../models/Blog.dart'; // Assurez-vous que le chemin d'importation est correct


class BlogService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.20.10.3:3000/blog",
    connectTimeout: Duration(milliseconds: 5000),  // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),  // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<Blog> getBlogById(int id) async {
    try {
      Response response = await _dio.get('/$id');
      if (response.statusCode == 200) {
        // Si la réponse est réussie, parsez les données JSON en objet Blog
        return Blog.fromJson(response.data);
      } else {
        // Gérer les autres statuts de réponse
        throw Exception('Failed to load blog');
      }
    } catch (e) {
      // Gérer les exceptions de la requête
      throw Exception('Failed to load blog: $e');
    }
  }
}
