import 'package:flutter/material.dart';
import 'package:rick_and_morty_kobe/components/character_card.dart';
import 'package:rick_and_morty_kobe/models/detailed_character.dart';
import 'package:rick_and_morty_kobe/pages/details_page.dart';
import 'package:rick_and_morty_kobe/repositories/character_repository.dart';
import 'package:rick_and_morty_kobe/themes/app_colors.dart';
import 'package:rick_and_morty_kobe/widgets/app_bar_widget.dart';
import 'package:rick_and_morty_kobe/components/filter_modal.dart';

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
  bool hasMore = true;
  late ScrollController _scrollController;
  String? selectedStatus;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadCharacters(reset: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore &&
        hasMore) {
      _loadCharacters();
    }
  }

  Future<void> _loadCharacters({bool reset = false}) async {
    if (reset) {
      setState(() {
        characters.clear();
        currentPage = 1;
        hasMore = true;
      });
    }

    setState(() => isLoadingMore = true);
    final data = await CharacterRepository.getAllCharacters(
      page: currentPage,
      status: selectedStatus,
      gender: selectedGender,
    );
    setState(() {
      characters.addAll(data.results);
      currentPage++;
      isLoadingMore = false;
      hasMore = data.next != null;
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
      appBar: appBarWidget(
        context,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _openFilterModal,
          ),
        ],
      ),
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

  void _openFilterModal() async {
    final filtroSelected = await showFilterModal(
      context,
      initialStatus: selectedStatus,
      initialGender: selectedGender,
    );
    if (filtroSelected != null) {
      if (filtroSelected['status'] == null &&
          filtroSelected['gender'] == null) {
        setState(() {
          selectedStatus = null;
          selectedGender = null;
        });
        _loadCharacters(reset: true);
        return;
      }
      setState(() {
        selectedStatus = filtroSelected['status'];
        selectedGender = filtroSelected['gender'];
      });
      _loadCharacters(reset: true);
    }
  }
}
