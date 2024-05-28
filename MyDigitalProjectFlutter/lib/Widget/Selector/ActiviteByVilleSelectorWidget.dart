import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../models/Activite.dart';
import '../../service/activite_service.dart'; // Assurez-vous que le chemin d'accès est correct
import 'dart:convert'; // For base64 decoding

class ActiviteListWidget extends StatefulWidget {
  final String ville;
  final Function(Activite) onActiviteSelected;

  const ActiviteListWidget({Key? key, required this.ville, required this.onActiviteSelected}) : super(key: key);

  @override
  _ActiviteListWidgetState createState() => _ActiviteListWidgetState();
}

class _ActiviteListWidgetState extends State<ActiviteListWidget> {
  List<Activite> activites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadActivites();
  }

  Future<void> loadActivites() async {
    ActiviteService activiteService = ActiviteService(); // Crée une instance du service
    activites = await activiteService.getActiviteByVille(widget.ville);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sélectionner une activité'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: activites.length,
        itemBuilder: (context, index) {
          final activite = activites[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                widget.onActiviteSelected(activite);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activite.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('${activite.adresse}, ${activite.ville}'),
                          SizedBox(height: 8.0),
                          Text('\$${activite.prix}'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    activite.img != null && activite.img.isNotEmpty
                        ? Image.memory(
                      base64Decode(activite.img),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
