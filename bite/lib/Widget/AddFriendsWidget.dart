import 'package:flutter/material.dart';
import '../service/user_service.dart'; // Assurez-vous que le chemin d'importation est correct
import '../service/social_service.dart'; // Assurez-vous que le chemin d'importation est correct
import '../models/User.dart'; // Assurez-vous que le chemin d'importation est correct

class AjoutAmis extends StatefulWidget {
  final int idUtilisateur;

  const AjoutAmis({Key? key, required this.idUtilisateur}) : super(key: key);

  @override
  _AjoutAmisState createState() => _AjoutAmisState();
}

class _AjoutAmisState extends State<AjoutAmis> {
  final UserService _userService = UserService();
  final SocialService _socialService = SocialService(); // Instance de SocialService
  final TextEditingController _searchController = TextEditingController();
  List<User> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un ami'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher par nom',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchUser,
                ),
              ),
              onSubmitted: (value) => _searchUser(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final user = _searchResults[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('ID: ${user.id}'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => _addFriend(user.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchUser() async {
    var name = _searchController.text;
    if (name.isNotEmpty) {
      try {
        var results = await _userService.searchUsersByName(name);
        setState(() {
          _searchResults = results;
        });
      } catch (e) {
        print('Erreur lors de la recherche : $e');
      }
    }
  }

  void _addFriend(int friendId) async {
    try {
      await _socialService.addFriend(widget.idUtilisateur, friendId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ami ajouté avec succès!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout de l\'ami : ${e.toString()}')),
      );
    }
  }
}
