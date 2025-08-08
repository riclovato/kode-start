
import 'package:dio/dio.dart';
import 'package:rick_and_morty_kobe/models/paginated_characters.dart';

class CharacterRepository {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
    
    ),
  );


static Future<PaginatedCharacters> getAllCharacters() async {
    final response = await _dio.get('/character');
    return PaginatedCharacters.fromJson(response.data);
}
    
}