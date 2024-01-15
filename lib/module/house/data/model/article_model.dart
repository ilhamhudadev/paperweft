// models/article.dart
class Article {
  int? id;
  String title;
  String content;

  Article({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(id: map['id'], title: map['title'], content: map['content']);
  }
}
