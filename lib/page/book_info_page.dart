import 'package:flutter/material.dart';

import 'package:rentabook/models/book.dart';
import 'package:rentabook/widget/subheader.dart';

class BookInfoPage extends StatefulWidget {

  final Book selectedBook;

  const BookInfoPage({Key key, @required this.selectedBook}) : super(key: key);

  @override
  _BookInfoPageState createState() => _BookInfoPageState(selectedBook);
}

class _BookInfoPageState extends State<BookInfoPage> {

  final Book selectedBook;

  _BookInfoPageState(this.selectedBook);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          subheader(context, 'More Info'),
          _buildBookInfo(),
        ],
      ),
    );
  }

  Widget _buildBookInfo() {
    return Center(
      child: Column(
        children: <Widget>[
          Text('UUIDUSER: ${selectedBook.uuidUser}'),
          Text('UUIDBOOK: ${selectedBook.uuidBook}'),
          Text('Title: ${selectedBook.bookTitle}'),
          Text('Author: ${selectedBook.authorName}'),
          Text('Publisher: ${selectedBook.publisherName}'),
          Text('Start Rent Date: ${selectedBook.startBorrowDate}'),
          Text('End Rent Date: ${selectedBook.endBorrowDate}'),
        ],
      ),
    );
  }
}
