import 'package:bite/screens/mon_voyage.dart';
import 'package:flutter/material.dart';
import '../Widget/NavigationWidget.dart';
import 'accueil_page.dart';
import 'creer_voyage_page.dart';
import 'mes_voyages_page.dart';
import 'parcourir_page.dart';
import 'profil_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AccueilPage(),
    CreerVoyagePage(),
    MesVoyagesPage(),
    ParcourirPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationWidget(
        currentIndex: _currentIndex,
        onSelect: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
