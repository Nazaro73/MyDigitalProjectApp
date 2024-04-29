import 'package:flutter/material.dart';

class CardDBZ extends StatelessWidget {
  final Map character;

  const CardDBZ({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Ink.image(
                image: NetworkImage(character['image']),
                height: 300

              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  character['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${character['race']} - ${character['gender']}'),
                const SizedBox(height: 10),
                Text('Base KI: ${character['ki']}',
                  style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 24,
                  ),
                ),
                Text('Total KI: ${character['maxKi']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 24,
                    ),),
                Text('Affiliation: ${character['affiliation']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 24,
                      ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
