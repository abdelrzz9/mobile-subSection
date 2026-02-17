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
  BookStatus status = BookStatus.available;
  BOOK(this.title, this.page, this.type);
}

class USER {
  String? id;
  String? name;
  MemberTier tier = MemberTier.standard;
  USER(this.name);
  List<String?> chapt = [];
}

List<BOOK> books = [];
List<USER> users = [];

Future<BOOK?> findBook(String? title) async {
  if (title == null) return null;
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

void displayBooks() {
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

void displayUser() {
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

Future<void> loanBook(String? nUs, String? nBok) async {
  if (await findBook(nBok) == null || await findUsre(nUs) == null) return;
}

Future<bool> isAvailable(String? title) async {
  final book = await findBook(title);
  if (book == null) return false;
  if (book.status == BookStatus.available) {
    return true;
  }
  return false;
}

Future<bool> canBorrow(USER? nUs) async {
  if (nUs == null || nUs.chapt.length > 3 ) return false;
  return true;
}

void main() {}
