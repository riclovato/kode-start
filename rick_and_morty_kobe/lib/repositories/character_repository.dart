import 'package:dio/dio.dart';
import 'package:rick_and_morty_kobe/models/detailed_character.dart';
import 'package:rick_and_morty_kobe/models/paginated_characters.dart';

class CharacterRepository {
  static final _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  static Future<PaginatedCharacters> getAllCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    final queryParams = {
      'page': page,
      if (name != null && name.isNotEmpty) 'name': name,
      if (status != null && status.isNotEmpty) 'status': status,
      if (species != null && species.isNotEmpty) 'species': species,
      if (type != null && type.isNotEmpty) 'type': type,
      if (gender != null && gender.isNotEmpty) 'gender': gender,
    };

    try {
      final response = await _dio.get(
        '/character',
        queryParameters: queryParams,
      );

      return PaginatedCharacters.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return PaginatedCharacters(
          results: [],
          next: null,
          prev: null,
          count: 0,
          pages: 0,
        );
      }

      rethrow;
    } catch (e) {
      print('Error getting characters: $e');
      rethrow;
    }
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
}
