import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/books_data.dart';

class BookSwipePage extends StatefulWidget {
  const BookSwipePage({super.key});

  @override
  State<BookSwipePage> createState() => _BookSwipePageState();
}

class _BookSwipePageState extends State<BookSwipePage> {
  final List<Book> _books = BookData.sampleBooks;

  int _currentIndex = 0;

  void _handleLike() {
    print('Liked ${_books[_currentIndex].title}');
    _nextBook();
  }

  void _handleDislike() {
    print('Disliked ${_books[_currentIndex].title}');
    _nextBook();
  }

  void _nextBook() {
    if (_currentIndex < _books.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Reset or show end of books message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No more books to show!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookSwipe'),
        automaticallyImplyLeading: false, // Prevents back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text('Book Cover Placeholder'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _books[_currentIndex].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _books[_currentIndex].author,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _books[_currentIndex].description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _handleDislike,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.close),
                ),
                FloatingActionButton(
                  onPressed: _handleLike,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.favorite),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}