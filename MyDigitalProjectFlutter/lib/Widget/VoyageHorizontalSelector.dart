import 'dart:convert';
import 'package:flutter/material.dart';
import '../service/voyage_service.dart';
import '../models/Voyage.dart';
import '../screens/mon_voyage.dart';

class VoyageVerticalList extends StatefulWidget {
  @override
  _VoyageVerticalListState createState() => _VoyageVerticalListState();
}

class _VoyageVerticalListState extends State<VoyageVerticalList> {
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
    return ListView.builder(
      itemCount: voyages.length,
      itemBuilder: (context, index) {
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
    );
  }
}
