class Book {
  final int? id;
  final String title;
  final String description;
  final int pageCount;
  final String excerpt;
  final String publishDate;

  Book({
    this.id,
    required this.title,
    required this.description,
    required this.pageCount,
    required this.excerpt,
    required this.publishDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      pageCount: json['pageCount'].toInt(),
      description: json['description'],
      excerpt: json['excerpt'],
      publishDate: json['publishDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pageCount': pageCount,
      'excerpt': excerpt,
      'publishDate': publishDate,
    };
  }
}
