import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UserArticlesEvent extends Equatable {
  const UserArticlesEvent();

  @override
  List<Object> get props => [];
}

class GetUserArticles extends UserArticlesEvent {
  const GetUserArticles();
}

class CreateUserArticle extends UserArticlesEvent {
  final String title;
  final String author;
  final String content;
  final File? imageFile;

  const CreateUserArticle({
    required this.title,
    required this.author,
    required this.content,
    this.imageFile,
  });

  @override
  List<Object> get props => [title, author, content];
}

class DeleteUserArticle extends UserArticlesEvent {
  final String articleId;

  const DeleteUserArticle(this.articleId);

  @override
  List<Object> get props => [articleId];
}