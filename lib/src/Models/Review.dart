import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String author;
  final String content;
  final String id;
  final String url;

  const Review({
    this.id,
    this.author,
    this.content,
    this.url,
  });

  static Review fromJson(dynamic json) {
    return Review(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      url: json['url'],
    );
  }

  @override
  List<Object> get props => [id, author, content, url];
}
