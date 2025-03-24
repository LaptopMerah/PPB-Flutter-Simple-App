
enum BookStatus { unread, reading, completed, postponed, canceled, favorite }

class Book {
  String title;
  String author;
  int year;
  BookStatus status;

  Book({required this.title, required this.author, required this.year, this.status = BookStatus.unread});
}
