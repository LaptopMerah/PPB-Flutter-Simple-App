import 'package:flutter/material.dart';
import 'package:simple_app/book.dart';

class BodyBook extends StatefulWidget {
  final Book? book;
  final Function(Book) onSave;
  final VoidCallback onCancel;

  BodyBook({this.book, required this.onSave, required this.onCancel});

  @override
  _BodyBookState createState() => _BodyBookState();
}

class _BodyBookState extends State<BodyBook> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _yearController = TextEditingController(
      text: widget.book?.year.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        Book(
          title: _titleController.text,
          author: _authorController.text,
          year: int.parse(_yearController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.book == null ? 'Add Book' : 'Edit Book',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                        validator:
                            (value) => value!.isEmpty ? 'Enter a title' : null,
                      ),
                      TextFormField(
                        controller: _authorController,
                        decoration: InputDecoration(labelText: 'Author'),
                        validator:
                            (value) => value!.isEmpty ? 'Enter an author' : null,
                      ),
                      TextFormField(
                        controller: _yearController,
                        decoration: InputDecoration(labelText: 'Year'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) return 'Enter a year';
                          final year = int.tryParse(value);
                          if (year == null ||
                              year < 1000 ||
                              year > DateTime.now().year) {
                            return 'Enter a valid year';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[400],
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: widget.onCancel,
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}