import 'package:rick_and_morty_kobe/repositories/character_repository.dart';

void main() async {
  final characterList = await CharacterRepository.getAllCharacters();

  for (var character in characterList.results) {
    print('ID: ${character.id}');
    print('Nome: ${character.name}');
    print('Espécie: ${character.species}');
    print('Status: ${character.status}');
    print('Gênero: ${character.gender}');
    print('Imagem: ${character.image}');
    print('---------------------------');
  }
}
