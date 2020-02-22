// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final typeId = 0;

  @override
  Book read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as DateTime,
      fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.uuidUser)
      ..writeByte(1)
      ..write(obj.uuidBook)
      ..writeByte(2)
      ..write(obj.bookTitle)
      ..writeByte(3)
      ..write(obj.authorName)
      ..writeByte(4)
      ..write(obj.publisherName)
      ..writeByte(5)
      ..write(obj.scope)
      ..writeByte(6)
      ..write(obj.startBorrowDate)
      ..writeByte(7)
      ..write(obj.endBorrowDate);
  }
}
