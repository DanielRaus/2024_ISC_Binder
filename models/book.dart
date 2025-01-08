class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImagePath;
  final double compatibilityScore;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImagePath,
    required this.compatibilityScore,
  });
}