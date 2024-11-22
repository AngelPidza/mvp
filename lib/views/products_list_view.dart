import 'package:flutter/material.dart';
import 'package:mvp/presenters/books_presenter.dart';
import '../models/book.dart';
import 'book_form_view.dart';

class BooksListView extends StatefulWidget {
  const BooksListView({super.key});

  @override
  State<BooksListView> createState() => _BooksListViewState();
}

class _BooksListViewState extends State<BooksListView> implements BooksView {
  late BooksPresenter _presenter;
  List<Book> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _presenter = BooksPresenter(this);
    _presenter.loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books Library',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: 'N. páginas: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: '${book.pageCount}\n',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Publicado: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                                TextSpan(
                                  text: book.publishDate,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue.shade700,
                            ),
                            onPressed: () => _showEditForm(book),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red.shade700,
                            ),
                            onPressed: () => _confirmDelete(book),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        elevation: 4,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: _showAddForm,
      ),
    );
  }

  void _showAddForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookFormView(
          onSubmit: (book) {
            _presenter.createBook(book);
          },
        ),
      ),
    );
  }

  void _showEditForm(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookFormView(
          book: book,
          onSubmit: (updatedBook) {
            _presenter.updateBook(book.id!, updatedBook);
          },
        ),
      ),
    );
  }

  void _confirmDelete(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirmar eliminación',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Text(
          '¿Estás seguro que deseas eliminar "${book.title}"?',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _presenter.deleteBook(book.id!);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  @override
  void onBooksLoaded(List<Book> books) {
    setState(() {
      _books = books;
      _isLoading = false;
    });
  }

  @override
  void onBookCreated() {
    _presenter.loadBooks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Libro creado exitosamente'),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void onBookUpdated() {
    _presenter.loadBooks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Libro actualizado exitosamente'),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void onBookDeleted() {
    _presenter.loadBooks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Libro eliminado exitosamente'),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void onError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
