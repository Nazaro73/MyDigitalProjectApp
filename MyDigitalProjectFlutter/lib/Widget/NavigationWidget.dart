import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelect;

  NavigationWidget({required this.currentIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onSelect,
      selectedItemColor: Colors.blue,  // Couleur des éléments sélectionnés
      unselectedItemColor: Colors.grey, // Couleur des éléments non sélectionnés
      backgroundColor: Colors.white,    // Couleur de fond de la barre
      type: BottomNavigationBarType.fixed, // Type fixe pour garder la couleur de fond
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Créer un voyage',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Mes voyages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Parcourir',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
