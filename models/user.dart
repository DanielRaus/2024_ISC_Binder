class User {
  final String name;
  final List<String> favoriteGenres;
  final List<String> preferredLanguages;
  final String profileImagePath;

  User({
    required this.name,
    required this.favoriteGenres,
    required this.preferredLanguages,
    required this.profileImagePath,
  });
}