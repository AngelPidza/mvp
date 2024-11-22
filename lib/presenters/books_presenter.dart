import '../models/book.dart';
import '../services/api_service.dart';

class BooksPresenter {
  final ApiService _apiService;
  final BooksView _view;

  BooksPresenter(this._view) : _apiService = ApiService();

  Future<void> loadBooks() async {
    try {
      final books = await _apiService.getBooks();
      _view.onBooksLoaded(books);
    } catch (e) {
      _view.onError(e.toString());
    }
  }

  Future<void> createBook(Book book) async {
    try {
      await _apiService.createBook(book);
      _view.onBookCreated();
    } catch (e) {
      _view.onError(e.toString());
    }
  }

  Future<void> updateBook(int id, Book book) async {
    try {
      await _apiService.updateBook(id, book);
      _view.onBookUpdated();
    } catch (e) {
      _view.onError(e.toString());
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await _apiService.deleteBook(id);
      _view.onBookDeleted();
    } catch (e) {
      _view.onError(e.toString());
    }
  }
}

abstract class BooksView {
  void onBooksLoaded(List<Book> Books);
  void onBookCreated();
  void onBookUpdated();
  void onBookDeleted();
  void onError(String error);
}
