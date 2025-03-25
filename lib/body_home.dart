import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_app/book.dart';

class BodyHome extends StatelessWidget {
  final List<Book> books;
  final Function(Book, int) onEdit;
  final Function(int) onRemove;

  BodyHome({required this.books, required this.onEdit, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/empty.json'), // Replace with your asset path
            ),
            SizedBox(height: 16),
            Text(
              'No books available',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          color: Colors.indigo[100],
          child: ListTile(
            title: Text(book.title),
            subtitle: Text('${book.author} (${book.year})'),
            trailing: PopupMenuButton<String>(
              color: Colors.indigo[50],
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'remove',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red[400]),
                      SizedBox(width: 8),
                      Text('Remove'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit(book, index);
                } else if (value == 'remove') {
                  onRemove(index);
                }
              },
            ),
          ),
        );
      },
    );
  }
}