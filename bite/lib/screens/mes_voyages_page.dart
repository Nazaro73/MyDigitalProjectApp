import 'dart:convert';
import 'package:flutter/material.dart';
import '../service/voyage_service.dart';
import '../models/Voyage.dart';
import '../screens/mon_voyage.dart';

class MesVoyagesPage extends StatefulWidget {
  @override
  _MesVoyagesPageState createState() => _MesVoyagesPageState();
}

class _MesVoyagesPageState extends State<MesVoyagesPage> {
  List<Voyage> voyages = [];

  @override
  void initState() {
    super.initState();
    _loadVoyages();
  }

  Future<void> _loadVoyages() async {
    try {
      voyages = await VoyageService().fetchUserVoyages();
      setState(() {});
    } catch (e) {
      print('Failed to load voyages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('My Voyages'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MonVoyagePage(voyageId: voyages[index].id),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                          child: Image.memory(
                            base64Decode(voyages[index].img),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: Text(
                              voyages[index].nomVoyage,
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: voyages.length,
            ),
          ),
        ],
      ),
    );
  }
}
