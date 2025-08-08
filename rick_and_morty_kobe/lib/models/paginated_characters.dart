import 'detailed_character.dart';

class PaginatedCharacters {
  PaginatedCharacters({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
    required this.results,
  });

  final int count;
  final int pages;
  final String next;
  final String? prev;
  final List<DetailedCharacter> results;

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json) {
    return PaginatedCharacters(
      count: json['info']['count'],
      pages: json['info']['pages'],
      next: json['info']['next'],
      prev: json['info']['prev'],
      results: List.from(json['results'])
          .map((e) => DetailedCharacter.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      },
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
