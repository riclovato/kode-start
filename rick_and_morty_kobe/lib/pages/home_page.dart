import 'package:flutter/material.dart';
import 'package:rick_and_morty_kobe/components/character_card.dart';
import 'package:rick_and_morty_kobe/models/detailed_character.dart';
import 'package:rick_and_morty_kobe/pages/details_page.dart';
import 'package:rick_and_morty_kobe/repositories/character_repository.dart';
import 'package:rick_and_morty_kobe/themes/app_colors.dart';
import 'package:rick_and_morty_kobe/widgets/app_bar_widget.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DetailedCharacter> characters = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadCharacters();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      _loadCharacters();
    }
  }

  Future<void> _loadCharacters() async {
    setState(() => isLoadingMore = true);
    final data = await CharacterRepository.getAllCharacters(page: currentPage);
    setState(() {
      characters.addAll(data.results);
      currentPage++;
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      backgroundColor: AppColors.backgroundColor,
      body: characters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: characters.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == characters.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return CharacterCard(
                  character: characters[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: characters[index].id,
                    );
                  },
                );
              },
            ),
    );
  }
}
