import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const String baseUrl = 'https://fakerestapi.azurewebsites.net/api/v1/';

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Books');
    }
  }

  Future<Book> createBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Books'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create Book');
    }
  }

  Future<Book> updateBook(int id, Book book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Books/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update Book');
    }
  }

  Future<void> deleteBook(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/Books/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete Book');
    }
  }
}
