import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_kobe/models/character_list.dart';
import 'package:rick_and_morty_kobe/repositories/character_repository.dart';

void main() {
  group('CharacterRepository (teste real com API)', () {
    test('deve buscar todos os personagens com sucesso', () async {
      final result = await CharacterRepository.getAllCharacters();

      expect(result, isA<CharacterListModel>());
      expect(result.results, isNotEmpty);
    });
  });
}
