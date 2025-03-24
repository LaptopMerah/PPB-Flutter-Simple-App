import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:simple_app/body_home.dart';
import 'package:simple_app/body_book.dart';
import 'package:simple_app/body_profile.dart';
import 'package:simple_app/book.dart';

void main() => runApp(MaterialApp(title: 'SmartReads', home: BookTracker()));

class BookTracker extends StatefulWidget {
  @override
  _BookTrackerState createState() => _BookTrackerState();
}

class _BookTrackerState extends State<BookTracker> {
  List<Book> books = [
    Book(
      title: "Harry Potter and the Sorcerer's Stone",
      author: "J.K. Rowling",
      year: 1997,
    ),
    Book(title: "Laskar Pelangi", author: "Andrea Hirata", year: 2005),
    Book(title: "Bumi Manusia", author: "Pramoedya Ananta Toer", year: 1980),
    Book(title: "Perahu Kertas", author: "Dee Lestari", year: 2009, status: BookStatus.completed),
  ];

  int _selectedIndex = 0;
  Book? _editingBook;
  int? _editingIndex;

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_selectedIndex == 0) {
      body = BodyHome(
        books: books,
        onEdit: (book, index) {
          setState(() {
            _editingBook = book;
            _editingIndex = index;
            _selectedIndex = 1;
          });
        },
        onRemove: (index) {
          setState(() {
            books.removeAt(index);
          });
        },
      );
    } else if (_selectedIndex == 1) {
      body = BodyBook(
        book: _editingBook,
        onSave: (book) {
          setState(() {
            if (_editingIndex != null) {
              books[_editingIndex!] = book;
            } else {
              books.add(book);
            }
            _editingBook = null;
            _editingIndex = null;
            _selectedIndex = 0;
          });
        },
        onCancel: () {
          setState(() {
            _editingBook = null;
            _editingIndex = null;
            _selectedIndex = 0;
          });
        },
      );
    } else {
      body = BodyProfile();
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('SmartReads'), backgroundColor: Colors.white),
      body: body,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFeeeeee),
        buttonBackgroundColor: Colors.indigo[100],
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(_editingBook == null ? Icons.add : Icons.edit, size: 30),
          Icon(Icons.person, size: 30),
        ],
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _editingBook = null;
            _editingIndex = null;
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}