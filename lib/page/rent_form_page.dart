import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:rentabook/models/book.dart';
import 'package:rentabook/widget/header.dart';

class RentFormPage extends StatefulWidget {
  @override
  _RentFormPageState createState() => _RentFormPageState();
}

class _RentFormPageState extends State<RentFormPage> {
  final _formKey = GlobalKey<FormState>();
  Book scanBook = Book("","","","","","",null,null);
  String qrCode = "";

  String _uuidUser;
  String _uuidBook;
  String _bookTitle;
  String _authorName;
  String _publisherName;
  String _scope;

  TextEditingController _uuidUserController = TextEditingController();
  TextEditingController _uuidBookController = TextEditingController();
  TextEditingController _bookTitleController = TextEditingController();
  TextEditingController _authorNameController = TextEditingController();
  TextEditingController _publisherNameController = TextEditingController();
  TextEditingController _scopeController = TextEditingController();

  @override
  void initState() {
    scan();
    super.initState();
  }

  void addBook(Book book) {
    final booksBox = Hive.box('books');
    booksBox.add(book);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.qrCode = qrCode);

      scanBook = Book.fromJson(json.decode(barcode));
      _uuidUser = "99fbf1a6-d3d1-478b-bdac-738a2ffabd21"; // TODO: Implement UUID Generator
      _uuidBookController.text = scanBook.uuidBook;
      _bookTitleController.text = scanBook.bookTitle;
      _authorNameController.text = scanBook.authorName;
      _publisherNameController.text = scanBook.publisherName;
      _scopeController.text = scanBook.scope;

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrCode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrCode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.qrCode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrCode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime _now = DateTime.now();
    DateTime _end = DateTime(_now.year, _now.month, _now.day + 7);
    String _todayDate = DateFormat('dd-MM-yyyy').format(_now);
    String _endDate = DateFormat('dd-MM-yyyy').format(_end);
    return Scaffold(
      body: Column(
        children: <Widget>[
          header(context, 'Register A Book', 'Easy as 1-2-3'),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: <Widget>[
                   SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Book Title'),
                    controller: _uuidBookController,
                    onSaved: (value) => _uuidBook = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Book Title'),
                    controller: _bookTitleController,
                    onSaved: (value) => _bookTitle = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Author Name'),
                    controller: _authorNameController,
                    onSaved: (value) => _authorName = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Publisher Name'),
                    controller: _publisherNameController,
                    onSaved: (value) => _publisherName = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Scope'),
                    controller: _scopeController,
                    onSaved: (value) => _scope = value,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Start Date:'),
                          Text(_todayDate),
                        ],
                      ),
                      SizedBox(width: 40),
                      Column(
                        children: <Widget>[
                          Text('End Date:'),
                          Text(_endDate),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Scan QR Code'),
                        onPressed: scan,
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        child: Text('Submit Application'),
                        onPressed: () {
                          _formKey.currentState.save();
                          final newBook = Book(_uuidUser, _uuidBook, _bookTitle,
                              _authorName, _publisherName, _scope, _now, _end);
                          addBook(newBook);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
