import 'package:flutter/material.dart';
import '../models/book.dart';

class BookFormView extends StatefulWidget {
  final Book? book;
  final Function(Book) onSubmit;

  const BookFormView({
    super.key,
    this.book,
    required this.onSubmit,
  });

  @override
  State<BookFormView> createState() => _BookFormViewState();
}

class _BookFormViewState extends State<BookFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _pageCountController;
  late TextEditingController _descriptionController;
  late TextEditingController _publishDateController;
  late TextEditingController _excerptController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _pageCountController =
        TextEditingController(text: widget.book?.pageCount.toString() ?? '');
    _descriptionController =
        TextEditingController(text: widget.book?.description ?? '');
    _publishDateController =
        TextEditingController(text: widget.book?.publishDate ?? '');
    _excerptController =
        TextEditingController(text: widget.book?.excerpt ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _pageCountController.dispose();
    _descriptionController.dispose();
    _publishDateController.dispose();
    _excerptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book == null ? 'Nuevo Libro' : 'Editar Libro',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Título',
                        labelStyle: TextStyle(color: Colors.blue.shade800),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un título';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pageCountController,
                      decoration: InputDecoration(
                        labelText: 'Número de páginas',
                        labelStyle: TextStyle(color: Colors.blue.shade800),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el número de páginas';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor ingrese un número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        labelStyle: TextStyle(color: Colors.blue.shade800),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una descripción';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _excerptController,
                      decoration: InputDecoration(
                        labelText: 'Extracto',
                        labelStyle: TextStyle(color: Colors.blue.shade800),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un extracto';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _publishDateController,
                      decoration: InputDecoration(
                        labelText: 'Fecha de publicación',
                        labelStyle: TextStyle(color: Colors.blue.shade800),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade800),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la fecha de publicación';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final book = Book(
                            id: widget.book?.id,
                            title: _titleController.text,
                            pageCount: int.parse(_pageCountController.text),
                            description: _descriptionController.text,
                            excerpt: _excerptController.text,
                            publishDate: _publishDateController.text,
                          );
                          widget.onSubmit(book);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.book == null
                            ? 'Crear Libro'
                            : 'Actualizar Libro',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
