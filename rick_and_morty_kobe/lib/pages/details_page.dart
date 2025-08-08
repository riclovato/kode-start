import 'package:flutter/material.dart';
import 'package:rick_and_morty_kobe/components/detailed_character_card.dart';
import 'package:rick_and_morty_kobe/models/detailed_character.dart';
import 'package:rick_and_morty_kobe/repositories/character_repository.dart';
import 'package:rick_and_morty_kobe/themes/app_colors.dart';
import 'package:rick_and_morty_kobe/widgets/app_bar_widget.dart';


class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.characterId, Key? key}) : super(key: key);

  final int characterId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedCharacter>? detailedCharacter;

  @override
  initState() {
    detailedCharacter = CharacterRepository.getCharacterDetails(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: detailedCharacter,
        builder: (context, AsyncSnapshot<DetailedCharacter> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [
                DetailedCharacterCard(detailedCharacter: data),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CharacterDetailedCard {
}