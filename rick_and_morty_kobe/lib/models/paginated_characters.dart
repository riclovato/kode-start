import 'dart:convert';
import 'detailed_character.dart'; 

class PaginatedCharacters {
  final Info info;
  final List<Character> results;
  
  PaginatedCharacters({required this.info, required this.results});

  factory PaginatedCharacters.fromMap(Map<String, dynamic> map) {
    return PaginatedCharacters(
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      results: (map['results'] as List<dynamic>)
          .map<Character>((x) => Character.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }

  factory PaginatedCharacters.fromJson(String source) =>
      PaginatedCharacters.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Info {
  final int count;
  final int pages;
  final String next;
  final Prev prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] as String,
      prev: Prev.fromMap(map['prev']),
    );
  }

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Prev {
  final String? url;
  Prev({this.url});

  factory Prev.fromMap(dynamic data) {
    if (data is String) {
      return Prev(url: data);
    }
    return Prev();
  }
}