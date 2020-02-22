import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {

  @HiveField(0)
  final String uuidUser;
  @HiveField(1)
  final String uuidBook;
  @HiveField(2)
  final String bookTitle;
  @HiveField(3)
  final String authorName;
  @HiveField(4)
  final String publisherName;
  @HiveField(5)
  final String scope;
  @HiveField(6)
  final DateTime startBorrowDate;
  @HiveField(7)
  final DateTime endBorrowDate;

  Book(this.uuidUser, this.uuidBook, this.bookTitle, this.authorName, this.publisherName, this.scope,
       this.startBorrowDate, this.endBorrowDate);


factory Book.fromJson(Map<String, dynamic> json) => _itemFromJson(json);

}

Book _itemFromJson(Map<String, dynamic> json) {
  return Book(
      "",
      json['uuid'] as String,
      json['bookTitle'] as String,
      json['authorName'] as String,
      json['publisherName'] as String,
      json['scope'] as String,
      null,
      null
  );
}