import 'package:hive/hive.dart';
import 'package:rentabook/models/book.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {

  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final List<Book> collectionRentBook;

  User(this.uuid, this.username, this.password, this.collectionRentBook);

}