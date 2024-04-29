import 'package:flutter/material.dart';
import '../models/voyage.dart';  // Assurez-vous d'importer votre modèle Voyage
import '../service/voyage_service.dart';  // Importez votre service de gestion des voyages

class CreerVoyagePage extends StatefulWidget {
  @override
  _CreerVoyagePageState createState() => _CreerVoyagePageState();
}

class _CreerVoyagePageState extends State<CreerVoyagePage> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  double budget = 0;
  String selectedTag = 'Aventure';
  String selectedHousing = 'Maison';
  final voyageService = VoyageService();  // Instance de VoyageService
  final List<String> tags = ['Aventure', 'Détente', 'Culture', 'Sport', 'Nature'];
  final List<String> housingTypes = ['Maison', 'Cabane', 'Caravane', 'Tente', 'Appartement'];
  String lieuDepart = 'sordogne';
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? selectedStartDate : selectedEndDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != (isStart ? selectedStartDate : selectedEndDate))
      setState(() {
        if (isStart) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un voyage'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          // Date Picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Date:'),
              TextButton(
                onPressed: () => _selectDate(context, true),
                child: Text("${selectedStartDate.toLocal()}".split(' ')[0]),
              ),
              Text('au'),
              TextButton(
                onPressed: () => _selectDate(context, false),
                child: Text("${selectedEndDate.toLocal()}".split(' ')[0]),
              ),
            ],
          ),
          // Lieu de départ
          TextField(
            decoration: InputDecoration(
              labelText: 'Lieu de départ',
            ),
          ),
          // Lieu d'arrivée
          TextField(
            decoration: InputDecoration(
              labelText: 'Lieu d\'arrivée',
            ),
          ),
          // Slider pour le budget
          ListTile(
            title: Text('Budget: \$${budget.toInt()}'),
            subtitle: Slider(
              min: 0,
              max: 20000,
              divisions: 40,
              value: budget,
              onChanged: (value) {
                setState(() {
                  budget = value;
                });
              },
            ),
          ),
          // Dropdown pour les tags
          DropdownButton<String>(
            isExpanded: true,
            value: selectedTag,
            onChanged: (newValue) {
              setState(() {
                selectedTag = newValue!;
              });
            },
            items: tags.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Dropdown pour le type d'habitation
          DropdownButton<String>(
            isExpanded: true,
            value: selectedHousing,
            onChanged: (newValue) {
              setState(() {
                selectedHousing = newValue!;
              });
            },
            items: housingTypes.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Bouton de soumission
          ElevatedButton(
            onPressed: () async {
              // Création de l'objet voyage
              final voyage = Voyage(
                  id: 0,
                  destination: lieuDepart,  // Utilisation du lieu de départ pour la destination
                  description: selectedTag,  // Utilisation du tag comme description
                  startDate: selectedStartDate,
                  endDate: selectedEndDate,
                  creator_id: 0,  // Vous devrez spécifier l'ID du créateur
                  budget: budget,
                  guests: [],  // Liste initialement vide, peut être mise à jour plus tard
                  activites: []  // Liste initialement vide, peut être mise à jour plus tard
              );
              try {
                // Envoi de l'objet voyage au service pour ajout via l'API
                await voyageService.addVoyage(voyage.toJson());
              } catch (e) {
                print('Erreur lors de l\'ajout du voyage: $e');
              }
            },
            child: Text('Crée mon voyage'),
          ),
        ],
      ),
    );
  }
}
