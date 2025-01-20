import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/book.dart';

class BookSwipePage extends StatefulWidget {
  const BookSwipePage({super.key});

  @override
  State<BookSwipePage> createState() => _BookSwipePageState();
}

class _BookSwipePageState extends State<BookSwipePage> {
  List<Book> _books = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.102:8080/books'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Received data: $data'); // Debug print
        if (data['success']) {
          setState(() {
            _books = (data['books'] as List)
                .map((bookJson) => Book.fromJson(bookJson))
                .toList();
            _isLoading = false;
          });
          print('Loaded ${_books.length} books'); // Debug print
        }
      } else {
        print('Error status code: ${response.statusCode}'); // Debug print
        _handleError('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e'); // Debug print
      _handleError('Error loading books: $e');
    }
  }

  void _handleError(String message) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No more books to show!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_books.isEmpty) {
      return const Center(
        child: Text('No books available'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Dismissible(
              key: Key(_books[_currentIndex].id.toString()),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  _handleDislike();
                } else {
                  _handleLike();
                }
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.favorite, color: Colors.green, size: 40),
                  ),
                ),
              ),
              secondaryBackground: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.close, color: Colors.red, size: 40),
                  ),
                ),
              ),
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _books[_currentIndex].coverImageUrl.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _books[_currentIndex].coverImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.book,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _books[_currentIndex].title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                              : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.book,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _books[_currentIndex].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
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
                      if (_books[_currentIndex].genres.isNotEmpty)
                        Wrap(
                          spacing: 4,
                          children: _books[_currentIndex].genres.map((genre) =>
                              Chip(
                                label: Text(genre),
                                backgroundColor: Colors.blue[100],
                              )
                          ).toList(),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            ' ${_books[_currentIndex].averageRating.toStringAsFixed(1)}/5.0',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.book, color: Colors.blue),
                          Text(
                            ' ${_books[_currentIndex].pages} pages',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Price: \$${_books[_currentIndex].price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            _books[_currentIndex].publisher,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_books[_currentIndex].formats.isNotEmpty)
                        Wrap(
                          spacing: 4,
                          children: _books[_currentIndex].formats.map((format) =>
                              Chip(
                                label: Text(format),
                                backgroundColor: Colors.green[100],
                              )
                          ).toList(),
                        ),
                    ],
                  ),
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
    );
  }
}
