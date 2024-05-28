import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../service/blog_service.dart'; // Assurez-vous que le chemin est correct
import '../Widget/BlogCarouselWidget.dart'; // Assurez-vous que le chemin est correct
import '../models/Blog.dart'; // Assurez-vous que le chemin est correct

class AccueilPage extends StatelessWidget {
  final BlogService blogService;

  AccueilPage({Key? key})
      : blogService = BlogService(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Blog>(
        future: blogService.getBlogById(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (snapshot.hasData) {
              Blog blog = snapshot.data!;
              // Création de la liste des items pour le carousel
              List<Map<String, String>> carouselItems = [
                {
                  'image': blog.image1,
                  'titre': blog.titre1,
                  'contenu': blog.contenu1,
                },
                {
                  'image': blog.image2,
                  'titre': blog.titre2,
                  'contenu': blog.contenu2,
                },
                {
                  'image': blog.image3,
                  'titre': blog.titre3,
                  'contenu': blog.contenu3,
                },
                {
                  'image': blog.image4,
                  'titre': blog.titre4,
                  'contenu': blog.contenu4,
                }
              ];
              return ImageTextCarousel(items: carouselItems);
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

