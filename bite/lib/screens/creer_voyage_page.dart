import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../models/Voyage.dart';
import '../service/voyage_service.dart';
import 'mon_voyage.dart'; // Assurez-vous d'importer la page MonVoyagePage

class CreerVoyagePage extends StatefulWidget {
  @override
  _CreerVoyagePageState createState() => _CreerVoyagePageState();
}

class _CreerVoyagePageState extends State<CreerVoyagePage> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  double budget = 0;
  String nomVoyage = '';
  String lieuDepart = '';
  String base64Image = '';
  File? imageFile;
  String? selectedTag;
  List<String> tags = [];
  final int creatorId = 1;
  final voyageService = VoyageService();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadTags();
  }

  void loadTags() async {
    try {
      tags = await voyageService.getTagVoyage();
      if (tags.isNotEmpty) {
        setState(() {
          selectedTag = tags[0];
        });
      }
    } catch (e) {
      print('Failed to load tags: $e');
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? selectedStartDate : selectedEndDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          selectedStartDate = picked;
        } else {
          selectedEndDate = picked;
        }
      });
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Encode = base64.encode(imageBytes);
      setState(() {
        this.imageFile = imageFile;
        base64Image = base64Encode;
      });
    }
  }

  Future<void> _submitVoyage() async {
    var newVoyage = Voyage(
      id: 1, // Exemple d'id, remplacez par la logique réelle pour générer l'id
      nomVoyage: nomVoyage,
      lieux: lieuDepart,
      budget: budget,
      startDate: selectedStartDate,
      endDate: selectedEndDate,
      creatorId: creatorId,
      img: base64Image,
      guests: [],
      activites: [],
      tag: selectedTag ?? 'Default Tag',
    );
    try {
      final response = await voyageService.addVoyage(newVoyage.toJsonCreate());
      if (response.statusCode != 500) {

        final responseData = response.data as Map<String, dynamic>;
        final int idVoyage = responseData['id_voyage'] as int;
        print(idVoyage);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MonVoyagePage(voyageId: idVoyage),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erreur lors de la création du voyage: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e , stacktrace) {
      print('$e et $stacktrace ');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la création du voyage: $e'),
        backgroundColor: Colors.red,
      ));
    }
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
          GestureDetector(
            onTap: pickImage,
            child: Container(
              height: 200,
              color: Colors.grey[300],
              child: imageFile == null
                  ? Center(child: Text('Tap to select an image'))
                  : Image.file(imageFile!),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(labelText: 'Nom du voyage'),
            onChanged: (value) => nomVoyage = value,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Lieu de départ'),
            onChanged: (value) => lieuDepart = value,
          ),
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
          DropdownButton<String>(
            value: selectedTag ?? 'Default Tag',
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTag = newValue;
                });
              }
            },
            items: tags.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitVoyage,
            child: Text('Crée mon voyage'),
          ),
        ],
      ),
    );
  }
}
