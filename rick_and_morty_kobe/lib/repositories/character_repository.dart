import 'package:dio/dio.dart';
import 'package:rick_and_morty_kobe/models/detailed_character.dart';
import 'package:rick_and_morty_kobe/models/paginated_characters.dart';

class CharacterRepository {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  static Future<PaginatedCharacters> getAllCharacters({int page = 1}) async {
    final response = await _dio.get(
      '/character',
      queryParameters: {'page': page},
    );
    return PaginatedCharacters.fromJson(response.data);
  }

  static Future<DetailedCharacter> getCharacterDetails(int id) async {
    final response = await _dio.get('/character/$id');
    final data = response.data;

    if (data['episode'] != null && data['episode'].isNotEmpty) {
      final firstEpisodeUrl = data['episode'][0];
      final epResponse = await _dio.get(firstEpisodeUrl);
      data['firstEpisodeName'] = epResponse.data['name'];
    } else {
      data['firstEpisodeName'] = 'Unknown';
    }

    return DetailedCharacter.fromJson(data);
  }

  static Future<PaginatedCharacters> getByName(String name, {int page = 1}) async {
  final response = await _dio.get(
    '/character',
    queryParameters: {
      'name': name,
      'page': page,
    },
  );
  return PaginatedCharacters.fromJson(response.data);
}
}
