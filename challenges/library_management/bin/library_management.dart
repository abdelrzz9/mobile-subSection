import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

enum BookStatus { available, loaned, reserved }

enum MemberTier { standard, premium }

class BOOK {
  String? id;
  String? title;
  String? type;
  int? page;
  BOOK(this.title, this.page, this.type);
}

class USER {
  String? id;
  String? name;
  MemberTier tier = MemberTier.standard;
  USER(this.name);
}

List<BOOK> books = [];
List<USER> users = [];

BOOK? findBook(String? title) {
  if (title == null) {
    return null;
  }
  try {
    return books.firstWhere((e) => e.title == title);
  } catch (e) {
    return null;
  }
}

// void addBook() {
//   BOOK? b;
//   b.title = stdin.readLineSync();
//   b.page = stdin.readLineSync();
//   b.type = stdin.readLineSync();
// }

void deletBook(String? title) {
  if (title == null) return;
  books.removeWhere((e) => e.title == title);
}

List<BOOK>? getBooksByName(String? title) {
  try {
    return books.where((e) => e.title == title).toList();
  } catch (e) {
    return null;
  }
}
void displayBooks()  {
  print('============');
  for (var book in books) {
    print(book.title);
    print(book.type);
    print('============');
  }
}

Future<USER?> findUsre(String? name) async {
  if (name == null) return null;
  try {
    return users.firstWhere((e) => e.name == name);
  } catch (e) {
    return null;
  }
}

Future<void> deleteUser(String? name) async {
  if (name == null) return;
  users.removeWhere((e) => e.name == name);
}

void displayUser(){
  print('=========');
  for (var user in users) {
    print(user.name);
    print('=========');
  }
}

Future<void> upgraidUser(String? name) async {
  final user = await findUsre(name);
  if (user == null) {
    return;
  }
  if (user.tier == MemberTier.standard) {
    user.tier = MemberTier.premium;
  }
}

void main() {}
