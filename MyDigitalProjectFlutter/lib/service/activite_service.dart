import 'package:dio/dio.dart';
import '../models/Activite.dart'; // Assurez-vous que le chemin d'importation est correct
import '../models/Voyage.dart';

class ActiviteService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.20.10.3:3000/activite",
    connectTimeout: Duration(milliseconds: 5000),  // 5000 millisecondes pour le délai de connexion
    receiveTimeout: Duration(milliseconds: 3000),  // 3000 millisecondes pour le délai de réception
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<List<Activite>> getActiviteByVille(String ville) async {
    List<Activite> activites = [];
    try {
      final response = await _dio.get('/ville/$ville');
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.data;
        activites = dataList.map((data) => Activite.fromJson(data)).toList();
      } else {
        print('Erreur lors de la récupération des activités: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur de réseau: $e');
    }
    return activites;
  }
}
