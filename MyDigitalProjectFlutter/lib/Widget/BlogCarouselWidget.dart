import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageTextCarousel extends StatelessWidget {
  final List<Map<String, String>> items;

  ImageTextCarousel({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 1.0, // Occupera toute la largeur de la page
        height: MediaQuery.of(context).size.height, // Prend la hauteur totale de l'écran
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        enableInfiniteScroll: true,
      ),
      items: items.map((item) {
        final bytes = base64Decode(item['image']!);
        final image = MemoryImage(bytes);
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Arrondit les bords de l'image
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4), // 40% transparent
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          item['titre']!,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6), // 60% transparent
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          item['contenu']!,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
