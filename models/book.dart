class Book {
  final int id;
  final String title;
  final String author;
  final List<String> genres;
  final List<String> languages;
  final List<String> formats;
  final String coverImageUrl;
  final double averageRating;
  final int pages;
  final double price;
  final String publisher;
  final DateTime publishDate;
  final String isbn;
  final bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genres,
    required this.languages,
    required this.formats,
    required this.coverImageUrl,
    required this.averageRating,
    required this.pages,
    required this.price,
    required this.publisher,
    required this.publishDate,
    required this.isbn,
    required this.isAvailable,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    try {
      return Book(
        id: json['id'] ?? 0,
        title: json['title']?.toString() ?? 'Unknown Title',
        author: json['author']?.toString() ?? 'Unknown Author',
        genres: _parseList(json['genres']),
        languages: _parseList(json['languages']),
        formats: _parseList(json['formats']),
        coverImageUrl: json['cover_image_url']?.toString() ?? '',
        averageRating: _parseDouble(json['average_rating']) ?? 0.0,
        pages: json['pages'] ?? 0,
        price: _parseDouble(json['price']) ?? 0.0,
        publisher: json['publisher']?.toString() ?? 'Unknown Publisher',
        publishDate: _parseDate(json['pubdate']),
        isbn: json['isbn']?.toString()?.trim() ?? '',
        isAvailable: json['is_available'] ?? true,
      );
    } catch (e) {
      print('Error parsing book: $e');
      // Return a default book in case of any parsing errors
      return Book(
        id: 0,
        title: 'Error Loading Book',
        author: 'Unknown',
        genres: [],
        languages: [],
        formats: [],
        coverImageUrl: '',
        averageRating: 0.0,
        pages: 0,
        price: 0.0,
        publisher: 'Unknown',
        publishDate: DateTime.now(),
        isbn: '',
        isAvailable: false,
      );
    }
  }

  // Helper method to parse lists safely
  static List<String> _parseList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    return [];
  }

  // Helper method to parse doubles safely
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // Helper method to parse dates safely
  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime.now();
    }
  }
}
