import 'dart:convert';  // Pour décoder la base64
import 'package:flutter/material.dart';
import '../models/User.dart';  // Import de la classe User

class UserCarousel extends StatelessWidget {
  final List<User> users;
  final ValueChanged<User> onUserSelected;

  UserCarousel({required this.users, required this.onUserSelected});

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? Center(child: Text('Pas d\'amis dispo'))
        : ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return GestureDetector(
          onTap: () => onUserSelected(user),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: MemoryImage(base64Decode(user.img)),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
