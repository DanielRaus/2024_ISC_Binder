import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';

class BookSwipeScreen extends StatefulWidget {
  const BookSwipeScreen({super.key});

  @override
  State<BookSwipeScreen> createState() => _BookSwipeScreenState();
}

class _BookSwipeScreenState extends State<BookSwipeScreen> {
  final CardSwiperController controller = CardSwiperController();

  // Sample books data
  final List<Book> books = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description: 'A story of decadence and excess...',
      coverImagePath: 'assets/images/gatsby.jpg',
      compatibilityScore: 95,
    ),
    Book(
      id: '2',
      title: '1984',
      author: 'George Orwell',
      description: 'A dystopian social science fiction...',
      coverImagePath: 'assets/images/1984.jpg',
      compatibilityScore: 88,
    ),
    // Add more sample books...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Books'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CardSwiper(
              controller: controller,
              cardsCount: books.length,
              onSwipe: _onSwipe,
              numberOfCardsDisplayed: 3,
              backCardOffset: const Offset(40, 40),
              padding: const EdgeInsets.all(24.0),
              cardBuilder: (context, index) => BookCard(book: books[index]),
            ),
          ),
        ],
      ),
    );
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (direction == CardSwiperDirection.right) {
      // Handle right swipe (like)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You liked ${books[previousIndex].title}!'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    return true;
  }
}