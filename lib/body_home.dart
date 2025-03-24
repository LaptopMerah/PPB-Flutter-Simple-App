import 'package:flutter/material.dart';
import 'package:simple_app/book.dart';

class BodyHome extends StatelessWidget {
  final List<Book> books;
  final Function(Book, int) onEdit;
  final Function(int) onRemove;

  BodyHome({required this.books, required this.onEdit, required this.onRemove});

  @override
  Widget build(BuildContext context) {
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
              itemBuilder:
                  (context) => [
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

// class BodyHome extends StatelessWidget {
//   final List<Book> books;

//   BodyHome({required this.books});
  
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: books.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(10),
//           color: Colors.indigo[100],
//           child: ListTile(
//             title: Text(books[index].title),
//             subtitle: Text('${books[index].author} (${books[index].year})'),
//             trailing: IconButton(
//               icon: Icon(Icons.edit),
              
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BodyBook(book: books[index]),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
