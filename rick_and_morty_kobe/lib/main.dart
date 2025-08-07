import 'package:flutter/material.dart';
import 'package:rick_and_morty_kobe/pages/details_page.dart';
import 'package:rick_and_morty_kobe/pages/home_page.dart';



void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomePage.routeId:
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => const HomePage(),
            );
            case DetailsPage.routeId:
              int characterId = settings.arguments as int;
              return MaterialPageRoute(
                settings: settings,
                builder: (context) => DetailsPage(characterId: characterId,),
              );
            default:
              return null;
              
        }
      },
    );
  }
}
