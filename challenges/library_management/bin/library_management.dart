import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

enum BookStatus { available, loaned, reserved }
enum MemberTier { standard, premium }

class BookNotFoundException implements Exception {
  String message;
  String toString();
}
class MemberNotFoundException implements Exception {
  String message;
  String toString();
}
class InvalidLoanException implements Exception {
  String message;
  String toString();
}

mixin Timestampable { 
  DateTime? createDat;
  DateTime? updateDat;
  void markCreated();
  void markUpdated();
  String getTimestampInfo();
}
mixin Searchable { 
  bool matchesQuery(String query);
  List<String> getSearchableFields();
}

abstract class LibraryItem { 
  String id;
  String title;
  LibraryItem(this.id, this.title);
  String getDetails();
  Map<String , dynamic> toMap();
  void printInfo();
}
abstract class Borrowable {
  bool isAvailable();
  void borrow(String memberId);
  void returnItem();
}



class Book extends LibraryItem 
with Timestampable , Searchable 
implements Borrowable {
  String author;
  String? isbn;
  String? description;
  BookStatus status;
  Set<String> genreTags;
  String? currentBorrowerTd;
  int pages;
  Book(String id, String title , this.author);
  Book.fromMap(Map<String, dynamic> map);
  Book.withGenres(String id, String title, this.author, {Set<String>? initialGenres});
  @override String getDetails();
  @override Map<String, dynamic> toMap();
  @override bool isAvailable();
  @override void borrow(String memberId);
  @override void returnItem();
  @override bool matchesQuery(String query);
  @override List<String> getSearchableFields();
  void updateStatus(BookStatus newStatus);
  void addGenre(String genre);
  String getStatusText();
}

class Member with Timestampable { 
  


  String id;
  String name;
  String? email;  
  String? phone ; 
  MemberTier tier;
  List<String> loanHistory;
  Member(this.id, this.name, this.tier) ; 
  Member.fromMap(Map<String, dynamic> map);  
  Member.premium(String id, String name, {String? email});
  Map<String, dynamic> toMap();
  void addToHistory(String bookId);
  int getMaxLoans();
  bool canBorrow();
  String getMemberInfo();
  void upgradeTier();
}

class Loan { String loanId
  String bookId;
  String memberId;
  DateTime loanDate;
  DateTime? dueDate;
  DateTime? returnDate;
  bool isReturned;
  Loan(this.loanId, this.bookId, this.memberId);
  Loan.fromMap(Map<String, dynamic> map);
  Loan.withDueDate(String loanId, String bookId, String memberId, {int dueDays = 14});
  Map<String, dynamic> toMap();
  void markReturned();
  bool isOverdue();
  int getDaysOverdue();
  String getLoanInfo();
  }
class LibraryManager {


 Map<String, Book> _books;
  Map<String, Member> _members;
  List<Loan> _loans;
  StreamController<String> _activityStream;
  int _bookCounter;
  int _memberCounter;
  int _loanCounter;
  LibraryManager();
  Future<void> addBook(Book book);
  Future<Book?> findBook(String id);
  Future<List<Book>> getAllBooks();
  Future<void> updateBook(String id, Book updatedBook);
  Future<void> deleteBook(String id);
  Future<List<Book>> getAvailableBooks();
  Future<List<Book>> getBooksByGenre(String genre);
  Future<List<Book>> getBooksByAuthor(String author);
  Future<void> addMember(Member member);
  Future<Member?> findMember(String id);
  Future<List<Member>> getAllMembers();
  Future<void> updateMember(String id, Member updatedMember);
  Future<void> deleteMember(String id);
  Future<List<Member>> getPremiumMembers();
  Future<List<Member>> getStandardMembers();
  Future<void> loanBook(String bookId, String memberId);
  Future<void> returnBook(String loanId);
  Future<void> reserveBook(String bookId, String memberId);
  Future<List<Loan>> getActiveLoans();
  Future<List<Loan>> getOverdueLoans();
  Future<List<Loan>> getMemberLoans(String memberId);
  Future<Loan?> findLoan(String loanId);
  Future<List<Book>> searchCatalog(String query);
  Future<List<Book>> advancedSearch({String? title, String? author, String? genre});
  int getTotalBooks();
  int getTotalMembers();
  int getActiveLoansCount();
  Map<BookStatus, int> getBookStatusDistribution();
  Map<MemberTier, int> getMemberTierDistribution();
  List<Book> getMostBorrowedBooks();
  Stream<String> get activityLog;
  void _logActivity(String message);
  void dispose();
  String _generateBookId();
  String _generateMemberId();
  String _generateLoanId();
  void _validateLoan(Book book, Member member);
}


String? readInput(String prompt){
  print(prompt);
  return stdin.readLineSync();
}
int? readInt(String prompt){
  return int.tryParse(readInput(prompt)?? '');
}
String readRequiredInput(String prompt){
  while(true){
    String input = readInput(prompt) ?? 'null';
    if( input != 'null'){
      return input;
    }
  }
}
int readRequiredInt(String prompt){
  while(true){
    int num  = readInt(prompt) ?? -1;
    if(num != -1){
      return num;
    }
  }
}
BookStatus selectBookStatus(){

}
MemberTier selectMemberTier();
bool confirm(String message);



void clearScreen();
void printHeader(String title);
void printSeparator();
void printSuccess(String message);
void printError(String message);
void printInfo(String message);
void printBookDetails(Book book);
void printMemberDetails(Member member);
void printLoanDetails(Loan loan);
void printTable(List<List<String>> data, List<String> headers);



Map<String, dynamic> bookToMap(Book book);
Book mapToBook(Map<String, dynamic> map);
String formatDate(DateTime date);
String formatDuration(Duration duration);



List<T> filterList<T>(List<T> list, bool Function(T) test);
List<R> mapList<T, R>(List<T> list, R Function(T) mapper);
T reduceList<T>(List<T> list, T Function(T, T) combine);
void forEachWithIndex<T>(List<T> list, void Function(int, T) action);



bool isBookAvailable(Book book) => book.status == BookStatus.available;
String getBookTitle(Book book) => book.title;
int countActiveLoans(List<Loan> loans) => loans.where((l) => !l.isReturned).length;
bool isMemberPremium(Member member) => member.tier == MemberTier.premium;









void main(){

}
