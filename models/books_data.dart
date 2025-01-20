import 'book.dart';

class BookData {
  static final List<Book> sampleBooks = [
    Book(
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description: 'A story of decadence and excess...',
      imageUrl: 'placeholder',
      language: 'English',
      genre: 'Fiction',
    ),
    Book(
      title: '1984',
      author: 'George Orwell',
      description: 'A dystopian social science fiction...',
      imageUrl: 'placeholder',
      language: 'English',
      genre: 'Science Fiction',
    ),
    // Add 8 more books...
  ];
}