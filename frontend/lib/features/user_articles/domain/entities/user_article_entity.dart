import 'package:equatable/equatable.dart';

class UserArticleEntity extends Equatable {
  final String? id;
  final String? title;
  final String? author;
  final String? content;
  final String? thumbnailURL;
  final DateTime? createdAt;

  const UserArticleEntity({
    this.id,
    this.title,
    this.author,
    this.content,
    this.thumbnailURL,
    this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      title,
      author,
      content,
      thumbnailURL,
      createdAt,
    ];
  }
}
