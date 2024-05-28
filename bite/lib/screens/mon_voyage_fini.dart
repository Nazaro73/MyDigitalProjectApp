import 'package:flutter/material.dart';
import '../models/Voyage.dart';
import '../models/Activite.dart';
import '../service/voyage_service.dart';
import '../Widget/Selector/ActiviteByVilleSelectorWidget.dart';

class MonVoyageFiniPage extends StatefulWidget {
  final int voyageId;

  MonVoyageFiniPage({Key? key, required this.voyageId}) : super(key: key);

  @override
  _MonVoyageFiniPageState createState() => _MonVoyageFiniPageState();
}

class _MonVoyageFiniPageState extends State<MonVoyageFiniPage> {
  late TextEditingController _nomController;
  late TextEditingController _lieuController;
  late TextEditingController _budgetController;
  DateTime? _startDate;
  DateTime? _endDate;
  List<Activite> _activites = [];
  bool _isLoading = true;
  Voyage? _voyage;

  @override
  void initState() {
    super.initState();
    // Initialisation par défaut des contrôleurs
    _nomController = TextEditingController();
    _lieuController = TextEditingController();
    _budgetController = TextEditingController();
    _fetchVoyage();
  }

  void _fetchVoyage() async {
    try {
      VoyageService service = VoyageService();
      Voyage voyage = await service.getVoyageById(widget.voyageId);

      setState(() {
        _voyage = voyage;
        _nomController.text = _voyage!.nomVoyage;
        _lieuController.text = _voyage!.lieux;
        _budgetController.text = _voyage!.budget.toString();
        _startDate = _voyage!.startDate;
        _endDate = _voyage!.endDate;
        _activites = List.from(_voyage!.activites);
        _isLoading = false;
      });
    } catch (e) {
      // Handle the error
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la récupération du voyage.')),
      );
    }
  }

  void _updateVoyage() async {
    var updateData = {
      "nomVoyage": _nomController.text,
      "lieux": _lieuController.text,
      "budget": double.parse(_budgetController.text),
      "startDate": _startDate?.toIso8601String(),
      "endDate": _endDate?.toIso8601String(),
      "activites": _activites.map((activite) => activite.toJson()).toList(),
      "guests": [],
    };

    try {
      VoyageService service = VoyageService();
      await service.updateVoyage(widget.voyageId, updateData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Voyage mis à jour avec succès!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la mise à jour du voyage.")),
      );
    }
  }

  void _addActivite(Activite activite) {
    setState(() {
      _activites.add(activite);
    });
  }

  void _openActiviteList() async {
    final selectedActivite = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActiviteListWidget(
          ville: _lieuController.text,
          onActiviteSelected: (activite) {
            Navigator.pop(context, activite);
          },
        ),
      ),
    );

    if (selectedActivite != null) {
      _addActivite(selectedActivite);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Détails du Voyage'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Voyage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'Nom du Voyage'),
            ),
            TextField(
              controller: _lieuController,
              decoration: InputDecoration(labelText: 'Lieu'),
            ),
            TextField(
              controller: _budgetController,
              decoration: InputDecoration(labelText: 'Budget (€)'),
              keyboardType: TextInputType.number,
            ),
            if (_startDate != null) Text('Début: ${_startDate!.toLocal()}'),
            if (_endDate != null) Text('Fin: ${_endDate!.toLocal()}'),
            SizedBox(height: 20),
            Text('Activités:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _activites.isEmpty
                ? Text('Aucune activité ajoutée')
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _activites.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_activites[index].name),
                    subtitle: Text('${_activites[index].adresse} - ${_activites[index].prix.toStringAsFixed(2)}€'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _activites.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: _openActiviteList,
              child: Text('Ajouter une activité'),
            ),
            ElevatedButton(
              onPressed: _updateVoyage,
              child: Text('Soumettre les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}
