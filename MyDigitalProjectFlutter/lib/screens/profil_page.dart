import 'package:flutter/material.dart';
import '../service/user_service.dart'; // Vérifiez le chemin d'importation
import '../models/User.dart'; // Vérifiez le chemin d'importation
import 'dart:convert';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserService().getMyProfile("ville");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Empêche le retour en arrière
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 0, // Hide the AppBar
        ),
        body: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return _buildProfile(snapshot.data!);
            } else {
              return Center(child: Text('No data'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfile(User user) {
    final image = user.img.isNotEmpty
        ? Image.memory(
      base64Decode(user.img),
      fit: BoxFit.cover,
    )
        : Icon(Icons.account_circle, size: 100);

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: image,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          '${user.name}',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildInfoRow('Genre', user.gender),
                      _buildInfoRow('Date de naissance', "23 aout 2002"),
                      _buildInfoRow('Mail', user.email),
                      SizedBox(height: 40),
                      Center(
                        child: Text(
                          'Paramètres de confidentialité',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Suppression de l'icône de retour
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Divider(color: Colors.white54),
        SizedBox(height: 8),
      ],
    );
  }
}
